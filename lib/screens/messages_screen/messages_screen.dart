import 'package:christabodenew/constants.dart';
import 'package:christabodenew/screens/global_components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/message_list_item.dart';

class MessagesScreen extends StatelessWidget {
  static const id = "messages_screen.dart";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const MessagesScreen());
  }

  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            const Text("Salvation"),
            const SizedBox(
              height: kDefaultPadding2x,
            ),
            MessageListItem(
              messageTitle: "message Title",
              messageExcerpt: """Lorem ipsum dolor sit amet, 
          consectetur adipiscing elit. Etiam eu turp""",
              onPressed: () {},
            ),
          ],
        ),
      )),
    );
  }
}

