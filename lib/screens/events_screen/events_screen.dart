import 'package:christabodenew/providers/events_provider.dart';
import 'package:christabodenew/screens/global_components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import 'components/event_card.dart';

class EventsScreen extends StatelessWidget {
  static const id = "events_screen.dart";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const EventsScreen());
  }

  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(builder: (context, eventData, child) {
      return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  "Events",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(
                  height: kDefaultPadding2x,
                ),
                Text(
                  "Upcoming Events for ${monthsOfYear[DateTime.now().month]}",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(height: kDefaultPadding),
                eventData.upcomingEvents.isNotEmpty
                    ? ListView.builder(
                        itemCount: eventData.upcomingEvents.length,
                        itemBuilder: (context, index) {
                          return EventCard(
                              event: eventData.upcomingEvents[index]);
                        })
                    : Center(
                        child: Column(
                          children: [
                            //  Spacer(),
                            Icon(
                              Icons.notifications_off_outlined,
                              size: MediaQuery.of(context).size.width * .3,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            Text(
                              "There are no events scheduled for now.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            //  Spacer(),
                          ],
                        ),
                      ),
                const SizedBox(height: kDefaultPadding2x),
                Text(
                  "Past Events",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(height: kDefaultPadding),
                eventData.pastEvents.isNotEmpty
                    ? ListView.builder(
                        itemCount: eventData.pastEvents.length,
                        itemBuilder: (context, index) {
                          return EventCard(event: eventData.pastEvents[index]);
                        })
                    : Center(
                        child: Column(
                          children: [
                            //    Spacer(),
                            Icon(
                              Icons.notifications_off_outlined,
                              size: MediaQuery.of(context).size.width * .3,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            Text(
                              "There are no past events.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            // Spacer(),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
