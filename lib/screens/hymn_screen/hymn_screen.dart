import 'package:christabodenew/screens/hymn_screen/hymn_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:christabodenew/providers/providers.dart';

import '../../core/constants.dart';
import 'components/hymn_card.dart';

class HymnScreen extends StatelessWidget {
  static const id = "hymn_screen.dart";
  final bool isCalledFromNavBar;
  static Route route() {
    return MaterialPageRoute(builder: (context) => const HymnScreen());
  }

  const HymnScreen({super.key, this.isCalledFromNavBar = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<HymnProvider>(
      builder: (context, hymnData, child) {

        return Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: kDefaultPadding2x,
                    ),
                    Text(
                      "Hymns",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: kDefaultPadding2x,
                    ),
                    Gap(kDefaultPadding),
                    Visibility(
                      visible: hymnData.allHymns.isNotEmpty,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: hymnData.allHymns.length,
                          //  itemCount: 2,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return HymnCard(
                              hymn: hymnData.allHymns[index],
                              onPressed: () {
                                hymnData.setHymnIndex(index);
                                Navigator.pushNamed(context, HymnScreenDetails.id);
                              },
                            );
                          }),
                      replacement: Center(child: Text("There are no hymns"),),
                    ),
                    Gap(kDefaultPadding2x),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
