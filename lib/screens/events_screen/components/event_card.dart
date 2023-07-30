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
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).primaryColor.withOpacity(.1)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              event.name.toTitleCase(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                  ),
            ),
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: kDefaultPadding),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                dateTimeFormatter(context, event.startDate),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16),
              ),
            ),
            event.endDate != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        "to ${dateTimeFormatter(context, event.endDate!)}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16)),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
