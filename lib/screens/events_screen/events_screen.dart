import 'package:christabodenew/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import 'components/event_list_builder.dart';

class EventsScreen extends StatelessWidget {
  static const id = "events_screen.dart";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const EventsScreen());
  }

  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(
      builder: (context, eventData, child) {
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
                      "Events",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: kDefaultPadding2x,
                    ),
                    Text(
                      "Upcoming Events for ${monthsOfYear[DateTime.now().month]}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!.copyWith(fontFamily: "Gloock")
                    ),
                    const Gap( kDefaultPadding),
                    BuildEventsList(events: eventData.upcomingEvents),
                    const Gap( kDefaultPadding2x),
                    Visibility(
                        visible: eventData.pastEvents.isNotEmpty,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Past Events",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!.copyWith(fontFamily: "Gloock")
                            ),
                            const Gap( kDefaultPadding),
                            BuildEventsList(
                              events: eventData.pastEvents,
                              messageIfEmpty: "There are no past events",
                            ),
                          ],
                        )),

                    const Gap( kDefaultPadding2x),

                    // Text("Showing all events for test"),
                    // BuildEventsList(
                    //   events: eventData.allEvents,
                    //   messageIfEmpty: "There are no past events",
                    // ),
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
