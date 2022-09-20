import 'package:christabodenew/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DevotionalScreen extends StatelessWidget {
  static const id = "devotional_screen";
  static Route route() {
    return MaterialPageRoute(builder: (context) => const DevotionalScreen());
  }

  const DevotionalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          collapsedHeight: 150,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/svg/back_icon.svg"),
          ),
          floating: true,
          pinned: true,
          //centerTitle: true,
          // title: Text(
          //   "Devotional page",
          //   style: Theme.of(context).textTheme.headline1,
          // ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.all(kDefaultPadding),
            expandedTitleScale: 1,
            title: Center(
              
              child: Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding2x),
                child: Text(
                "You have been called as a chose one to show the power of ahh", textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
          ),
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/road_image.jpg"),
              ),),
             
            ),
          ),
          expandedHeight: 300,
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
                color: kBlue20,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding2x),
                  topRight: Radius.circular(kDefaultPadding2x),
                )),
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                top: kDefaultPadding),
            child: Column(
              children: [
                //Misters Name and actions

                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ministers name",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "Date",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/svg/share_icon.svg",
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/svg/heart_icon.svg",
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/svg/settings_icon.svg",
                        color: Theme.of(context).iconTheme.color,
                      ),
                    )
                  ],
                ),
                Text(
                    "Scripure reading, Scripure reading, Scripure reading, Scripure reading, Scripure reading ",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text("Scripture reference")),

                SizedBox(
                  height: kDefaultPadding2x,
                ),
                Text(
                  "Message Body",
                  textAlign: TextAlign.left,
                ),

                Container(
                  height: 800,
                  width: double.infinity,
                  color: kFuchsia,
                  child: Text("hey guys"),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
