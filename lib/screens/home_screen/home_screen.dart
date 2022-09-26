import 'package:christabodenew/constants.dart';
import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/screens/home_screen/components/devotional_card.dart';
import 'package:christabodenew/screens/home_screen/components/video_card.dart';
import 'package:christabodenew/screens/messages_screen/messages_screen.dart';
import 'package:flutter/material.dart';

import '../../models/prayer_model.dart';
import '../devotional_screen/devotional_screen.dart';
import 'components/prayer_card.dart';

class HomeScreen extends StatelessWidget {
  static const id = "home_screen";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: kDefaultPadding),
                  Text("Welcome", style: Theme.of(context).textTheme.headline1),
                  const SizedBox(
                    height: kDefaultPadding2x,
                  ),
                  Text(
                    "Today's Devotional",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  DevotionalCard(
                      devotional: DevotionalMessage(
                        author: "author",
                        messageContent: "messsageContent",
                        messageTitle: "message title",
                        confessionOfFaith: "confession of faith",
                        endDate: DateTime.now(),
                        scripture: "scirpture",
                        scriptureReference: "scripture ref",
                        startDate: DateTime.now(),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, DevotionalScreen.id);
                      }),
                  const SizedBox(height: kDefaultPadding2x),
                  Text(
                    "Today's Prayer Fragrance",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  PrayerCard(
                    prayer: Prayer(
                      date: DateTime.now(),
                      prayerMessage: 'prayer Message',
                      prayerTitle: 'prayer title',
                      scripture: 'scripture',
                      scriptureReference: 'scripture ref',
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(height: kDefaultPadding2x),
                  Text(
                    "Videos",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  const VideoCard(),
                  const SizedBox(height: kDefaultPadding2x),
                  Text(
                    "Messages",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  InkWell(
                    borderRadius: BorderRadius.circular(kDefaultPadding+8),
                    onTap: (){
                      Navigator.pushNamed(context, MessagesScreen.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding2x + 8,
                          vertical: kDefaultPadding + 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultPadding+8),
                          color: kBlue60),
                      child: Text(
                        "Category",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
