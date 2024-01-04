import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/providers/events_provider.dart';
import 'package:christabodenew/providers/prayer_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:christabodenew/screens/hymn_screen/hymn_screen.dart';
import 'package:christabodenew/screens/prayer_screen/prayer_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/prayer_model.dart';
import '../../providers/devotional_provider.dart';
import '../devotional_screen/devotional_screen.dart';
import 'components/devotional_and_prayer_card.dart';
import 'components/featured_event_card.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    return Consumer4<DevotionalProvider, PrayerProvider, EventsProvider,
        UnsplashImageProvider>(
      builder: ((context, devotionalData, prayerData, eventData, unsplashData,
          child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(kDefaultPadding2x),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text("Christ Abode\nMinistries",
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),
                  const SizedBox(height: 48),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Visibility(
                        //visible: eventData.upcomingEvents.isNotEmpty,
                      visible: true,
                      replacement: Center(
                        child: Text(
                          "There are no upcoming events scheduled for now.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Visibility(

                                visible: eventData.upcomingEvents.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start  ,
                              children: [
                                Text(
                                  "Upcoming Services",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontFamily: 'Gloock'),
                                ),
                                const Gap(kDefaultPadding),
                                FeaturedEventCard(
                                    onSharePressed: (){
                                      eventData.shareEvent(context, eventData.upcomingEvents.first);
                                    },
                                    event: eventData.upcomingEvents.first,
                                    featuredImage: unsplashData.eventFeaturedImage),
                              ],
                            ))

                          ],
                        ),

                    ),
                  ),
                  const Gap(kDefaultPadding2x),
                  Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding),
                    child: Text(
                      "Devotional & Prayer",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontFamily: 'Gloock'),
                    ),
                  ),
                  const Gap(kDefaultPadding),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Gap(kDefaultPadding),
                        DevotionalAndPrayerCard(


                            onPressed: () async {
                              await devotionalData
                                  .getTodaysDevotionalIndex()
                                  .whenComplete(() {
                                Navigator.pushNamed(
                                    context, DevotionalScreen.id);
                              });

                              /// running this method will ensure that the right index for the devotional
                              /// of today is gotten and sent to the the current devotional index, even
                              /// if the user was scrolling and changing devotionals indexes
                            },
                            featuredImage: unsplashData.devotionalFeaturedImage,
                            devotional: devotionalData.todaysDevotional ??
                                Devotional.empty),
                        const Gap(kDefaultPadding),
                        DevotionalAndPrayerCard(
                            onPressed: () async {
                              await prayerData
                                  .getTodaysPrayerIndex()
                                  .whenComplete(() {
                                Navigator.pushNamed(context, PrayerScreen.id);
                              });

                              /// running this method will ensure that the right index for the prayer
                              /// of today is gotten and sent to the the current prayer index, even
                              /// if the user was scrolling and changing prayer indexes
                            },
                            featuredImage: unsplashData.prayerFeaturedImage,
                            prayer: prayerData.todaysPrayer ?? Prayer.empty),
                        const Gap(kDefaultPadding),
                      ],
                    ),
                  ),
                  const Gap(kDefaultPadding2x),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      splashFactory: InkSparkle.splashFactory,
                      splashColor: AppColours.blue90,
                      borderRadius: BorderRadius.circular(24),
                      onTap: (){
                        Navigator.pushNamed(context, HymnScreen.id);
                      },
                      child: Ink(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Get Spirit Inspired\nHymns to lift your soul",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                  height: 1.2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    )),
                            Align(
                              alignment: Alignment.centerRight,
                              child:
                              Icon(
                                  FluentIcons.arrow_right_24_regular,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,

                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(kDefaultPadding2x)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
