import 'package:christabodenew/core/date_time_formatter.dart';
import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kDefaultPadding + 8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(event.name.toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge),
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(dateTimeFormatter(context, event.startDate),
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            event.endDate != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        "to ${dateTimeFormatter(context, event.endDate!)}",
                        style: Theme.of(context).textTheme.bodyMedium),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
