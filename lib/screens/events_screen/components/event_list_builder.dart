import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/event_model.dart';
import 'event_card.dart';

class BuildEventsList extends StatelessWidget {
  final List<Event> events;
  final String? messageIfEmpty;
  const BuildEventsList({super.key, required this.events, this.messageIfEmpty});

  @override
  Widget build(BuildContext context) {
    if (events.isNotEmpty) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return EventCard(event: events[index]);
          });
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  Spacer(),
            Icon(
              FluentIcons.alert_off_24_regular,
              size: MediaQuery.of(context).size.width * .3,
              color: Theme.of(context).primaryColor.withOpacity(.3),
            ),
            const SizedBox(height: kDefaultPadding),
            Text(
              messageIfEmpty ?? "There are no events scheduled for now.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            //  Spacer(),
          ],
        ),
      );
    }
  }
}
