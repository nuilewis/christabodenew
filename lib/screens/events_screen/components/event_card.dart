import 'package:christabodenew/core/date_time_formatter.dart';
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
      aspectRatio: 16.0 / 9.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding2x),
            image: const DecorationImage(
                image: AssetImage("assets/images/road_image.jpg"),
                fit: BoxFit.cover),
            gradient: LinearGradient(
              colors: [Colors.transparent, kDark20],
              //  stops: [0.3, 0.9 ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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
                      event.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      event.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: kDefaultPadding,
                bottom: kDefaultPadding,
                child: Column(
                  children: [
                    Text(
                      dateTimeFormatter(context, event.startDate),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                    event.endDate != null
                        ? Text(
                            dateTimeFormatter(context, event.endDate!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18, color: Colors.white),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
