import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/models/event_model.dart';
import 'package:christabodenew/models/unsplash_image.dart';
import 'package:christabodenew/providers/events_provider.dart';
import 'package:christabodenew/providers/messages_provider.dart';
import 'package:christabodenew/providers/prayer_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:christabodenew/screens/devotional_screen/components/featured_image.dart';
import 'package:christabodenew/screens/home_screen/components/devotional_card.dart';
import 'package:christabodenew/screens/messages_screen/messages_screen.dart';
import 'package:christabodenew/screens/prayer_screen/prayer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../core/date_time_formatter.dart';
import '../../models/prayer_model.dart';
import '../../providers/devotional_provider.dart';
import '../devotional_screen/devotional_screen.dart';
import '../events_screen/components/event_card.dart';
import 'components/devotional_and_prayer_card.dart';
import 'components/featured_event_card.dart';
import 'components/prayer_card.dart';

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
  void didChangeDependencies() {
    Provider.of<DevotionalProvider>(context).getCurrentDevotional();
    Provider.of<PrayerProvider>(context).getCurrentPrayer();
    Provider.of<EventsProvider>(context).getUpcomingEvents();
    super.didChangeDependencies();
  }

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
                  const SizedBox(height: kDefaultPadding2x),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text("Christ Abode Ministries",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall),
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upcoming Events",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        eventData.upcomingEvents.isNotEmpty
                            ? FeaturedEventCard(
                                event: eventData.upcomingEvents.first,
                                featuredImage:
                                    unsplashData.devotionalFeaturedImage)
                            : Text(
                                "There are no upcoming events scheduled for now.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding2x),
                  Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding),
                    child: Text(
                      "Devotional & Prayer",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: kDefaultPadding),
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
                        const SizedBox(width: kDefaultPadding),
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
                        const SizedBox(width: kDefaultPadding),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                ],
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
            color: AppColours.blue70),
        child: Text(
          "Category",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
