import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/event_model.dart';
import 'event_card.dart';

class BuildEventsList extends StatelessWidget {
  final List<Event> events;
  final String? messageIfEmpty;
  const BuildEventsList({Key? key, required this.events, this.messageIfEmpty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return events.isNotEmpty
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return EventCard(event: events[index]);
            })
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //  Spacer(),
                Icon(
                  Icons.notifications_off_outlined,
                  size: MediaQuery.of(context).size.width * .3,
                  color: Theme.of(context).primaryColor.withOpacity(.3),
                ),
                const SizedBox(height: kDefaultPadding),
                Text(
                  messageIfEmpty ?? "There are no events scheduled for now.",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                //  Spacer(),
              ],
            ),
          );
  }
}
