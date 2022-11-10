import 'package:christabodenew/screens/global_components/app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';
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
      appBar: const CustomAppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text("Salvation", style: Theme.of(context).textTheme.headline2,),
            const SizedBox(
              height: kDefaultPadding2x,
            ),
            MessageListItem(
              messageTitle: "message Title",
              messageExcerpt: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turp",
              onPressed: () {},
            ),
          ],
        ),
      )),
    );
  }
}

