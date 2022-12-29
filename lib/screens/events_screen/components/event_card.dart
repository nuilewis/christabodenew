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
    return AspectRatio(
      aspectRatio: 20.0 / 9.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(kDefaultPadding2x),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: kDefaultPadding,
                  top: kDefaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name.toTitleCase(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        event.description,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateTimeFormatter(context, event.startDate),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16),
                      ),
                      event.endDate != null
                          ? Text(
                              "to ${dateTimeFormatter(context, event.endDate!)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 16))
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
