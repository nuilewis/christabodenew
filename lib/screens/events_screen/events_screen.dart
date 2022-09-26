import 'package:christabodenew/constants.dart';
import 'package:christabodenew/screens/global_components/app_bar.dart';
import 'package:flutter/material.dart';

import 'components/event_card.dart';

class EventsScreen extends StatelessWidget {
  static const id = "events_screen.dart";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const EventsScreen());
  }

  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:kDefaultPadding),
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
              height: kDefaultPadding,
            ),
            Text(
              "Upcoming",
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),
            ),
            const EventCard(
              eventDate: "Sunday 02/02/2022",
              eventName: "In Christ Musical Carnival",
            ),
            const EventCard(
              eventDate: "Sunday 02/i2/2022",
              eventName: "Feast of InGathering",
            ),
        ],
      ),
          ),),
    );
  }
}

