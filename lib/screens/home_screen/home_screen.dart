import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/providers/events_provider.dart';
import 'package:christabodenew/providers/messages_provider.dart';
import 'package:christabodenew/providers/prayer_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:christabodenew/screens/home_screen/components/devotional_card.dart';
import 'package:christabodenew/screens/messages_screen/messages_screen.dart';
import 'package:christabodenew/screens/prayer_screen/prayer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/prayer_model.dart';
import '../../providers/devotional_provider.dart';
import '../devotional_screen/devotional_screen.dart';
import '../events_screen/components/event_card.dart';
import 'components/prayer_card.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<DevotionalProvider>(context).getCurrentDevotional();
    Provider.of<PrayerProvider>(context).getCurrentPrayer();
    Provider.of<EventsProvider>(context).getUpcomingEvents();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<DevotionalProvider, PrayerProvider, MessagesProvider,
        EventsProvider>(
      builder: ((context, devotionalData, prayerData, messagesData, eventData,
          child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: kDefaultPadding * 3),
                      Text("Welcome to the Christ Abode Ministries",
                          style: Theme.of(context).textTheme.headline1),
                      const SizedBox(
                        height: kDefaultPadding * 3,
                      ),
                      Text(
                        "Next Up",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      eventData.upcomingEvents.isNotEmpty
                          ? EventCard(event: eventData.monthlyEvents.first)
                          : Text(
                              "There are no upcoming events scheduled for now.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),

                      const SizedBox(height: kDefaultPadding2x),
                      Text(
                        "Today's Huios Devotional",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      DevotionalCard(
                          devotional: devotionalData.todaysDevotional ??
                              Devotional.empty,
                          onPressed: () {
                            devotionalData.getTodaysDevotionalIndex();
                            Provider.of<UnsplashImageProvider>(context,
                                    listen: false)
                                .getRandomImage();

                            /// running this method will ensure that the right index for the devotional
                            /// of today is gotten and sent to the the current devotional index, even
                            /// if the user was scrolling and changing devotionals indexes

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
                        prayer: prayerData.todaysPrayer ?? Prayer.empty,
                        onPressed: () {
                          prayerData.getTodaysPrayerIndex();

                          /// running this method will ensure that the right index for the prayer
                          /// of today is gotten and sent to the the current prayer index, even
                          /// if the user was scrolling and changing prayer indexes

                          Navigator.pushNamed(context, PrayerScreen.id);
                        },
                      ),
                      const SizedBox(height: kDefaultPadding2x),
                      // Text(
                      //   "Videos",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .headline2!
                      //       .copyWith(fontSize: 24),
                      // ),
                      // const SizedBox(height: kDefaultPadding),
                      // const VideoCard(),
                      // const SizedBox(height: kDefaultPadding2x),

                      // Text(
                      //   "Messages",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .headline2!
                      //       .copyWith(fontSize: 24),
                      // ),
                      // const SizedBox(height: kDefaultPadding),
                      // const MessagesCategoryItem(),
                      const SizedBox(height: kDefaultPadding2x),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class MessagesCategoryItem extends StatelessWidget {
  const MessagesCategoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(kDefaultPadding + 8),
      onTap: () {
        Navigator.pushNamed(context, MessagesScreen.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding2x + 8, vertical: kDefaultPadding + 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding + 8),
            color: kBlue60),
        child: Text(
          "Category",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
