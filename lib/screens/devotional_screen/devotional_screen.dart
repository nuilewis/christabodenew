import 'package:christabodenew/core/date_time_formatter.dart';
import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/devotional_model.dart';

class DevotionalScreen extends StatelessWidget {
  static const id = "devotional_screen";
  final bool isCalledFromNavBar;
  static Route route() {
    return MaterialPageRoute(builder: (context) => const DevotionalScreen());
  }

  const DevotionalScreen({Key? key, this.isCalledFromNavBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DevotionalProvider>(
        builder: ((context, devotionalData, child) {
      Devotional todaysDevotional =
          devotionalData.todaysDevotional ?? Devotional.empty;
      return Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            collapsedHeight: 150,
            leading: isCalledFromNavBar
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset("assets/svg/back_icon.svg"),
                  ),
            floating: true,
            pinned: true,
            //centerTitle: true,
            // title: Text(
            //   "Devotional page",
            //   style: Theme.of(context).textTheme.headline1,
            // ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.all(kDefaultPadding),
              expandedTitleScale: 1,
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding2x),
                  child: Text(
                    todaysDevotional.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/road_image.jpg"),
                  ),
                ),
              ),
            ),
            expandedHeight: 300,
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kDefaultPadding2x),
                topRight: Radius.circular(kDefaultPadding2x),
              )),
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding),
              child: Column(
                children: [
                  //Misters Name and actions

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todaysDevotional.author,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            "${dateTimeFormatter(context, todaysDevotional.startDate)} - ${dateTimeFormatter(context, todaysDevotional.endDate)}",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/svg/share_icon.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/svg/heart_icon.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/svg/settings_icon.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Text(todaysDevotional.scripture,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(todaysDevotional.scriptureReference)),

                  const SizedBox(
                    height: kDefaultPadding2x,
                  ),
                  Text(
                    todaysDevotional.content,
                    textAlign: TextAlign.left,
                  ),

                  // Container(
                  //   height: 800,
                  //   width: double.infinity,
                  //   color: kFuchsia,
                  //   child: const Text("hey guys"),
                  // )
                ],
              ),
            ),
          )
        ]),
      );
    }));
  }
}
