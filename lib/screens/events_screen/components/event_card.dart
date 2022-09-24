import 'package:flutter/material.dart';

import '../../../constants.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final String? eventDescription;
  final String eventDate;
  const EventCard({
    Key? key,
    required this.eventName,
    this.eventDescription,
    required this.eventDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
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
                    children: [
                      Text(
                        eventName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        eventDescription ?? "An event like no other",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                  child: Text(
                    "Sunday 02/02/2022",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
