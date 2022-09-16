import 'package:christabodenew/constants.dart';
import 'package:christabodenew/screens/home_screen/components/devotional_card.dart';
import 'package:christabodenew/screens/home_screen/components/video_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Text("Welcome", style: Theme.of(context).textTheme.headline2),
              const SizedBox(
                height: kDefaultPadding2x,
              ),
              Text(
                "Today's Devotional",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 24),
              ),
              DevotionalCard(
                  title: "Message", excerpt: "Excerp", onPressed: () {}),
              const SizedBox(height: kDefaultPadding),
              Text(
                "Today's Prayer Fragrance",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 24),
              ),
              const SizedBox(height: kDefaultPadding),
              DevotionalCard(
                title: "prayer",
                excerpt: "Excerpt",
                isPrayerCard: true,
                onPressed: () {},
              ),
              Text(
                "Videos",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 24),
              ),
              VideoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
