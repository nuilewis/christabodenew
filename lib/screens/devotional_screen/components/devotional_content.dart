import 'package:christabodenew/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../core/date_time_formatter.dart';
import '../../../models/devotional_model.dart';
import '../../../models/settings_model.dart';
import 'next_previous_button.dart';

class DevotionalContent extends StatelessWidget {
  final Devotional currentDevotional;
  final VoidCallback onNextButtonPressed;
  final VoidCallback onPreviousButtonPressed;
  final VoidCallback onShareButtonPressed;
  final VoidCallback onLikedButtonPressed;
  const DevotionalContent(
      {Key? key,
      required this.currentDevotional,
      required this.onNextButtonPressed,
      required this.onPreviousButtonPressed,
      required this.onLikedButtonPressed,
      required this.onShareButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsData, child) {
        Settings currentSettings = settingsData.userSettings;
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding2x),
            topRight: Radius.circular(kDefaultPadding2x),
          )),
          padding: const EdgeInsets.only(
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
                        currentDevotional.author,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        "${dateTimeFormatter(context, currentDevotional.startDate)} to ",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        dateTimeFormatter(context, currentDevotional.endDate),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onShareButtonPressed,
                    icon: SvgPicture.asset(
                      "assets/svg/share_icon.svg",
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  IconButton(
                    onPressed: onLikedButtonPressed,
                    icon: SvgPicture.asset(
                      currentDevotional.isLiked
                          ? "assets/svg/heart_icon_filled.svg"
                          : "assets/svg/heart_icon.svg",
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final bool isDarkMode = currentSettings.isDarkMode;

                      Settings updatedSettings =
                          currentSettings.copyWith(isDarkMode: !isDarkMode);

                      await settingsData.updateSettings(updatedSettings);
                    },
                    icon: SvgPicture.asset(
                      currentSettings.isDarkMode
                          ? "assets/svg/light_mode_icon.svg"
                          : "assets/svg/dark_mode_icon.svg",
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(currentDevotional.scripture,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(currentDevotional.scriptureReference)),

              const SizedBox(
                height: kDefaultPadding2x,
              ),
              Text(
                currentDevotional.content,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  NextPreviousButton(
                      onPressed: onPreviousButtonPressed, isNextButton: false),
                  const Spacer(),
                  NextPreviousButton(onPressed: onNextButtonPressed)
                ],
              ),
              const SizedBox(height: kDefaultPadding2x),
              Text(
                "Christ Abode Ministries",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 12,
                    color: Theme.of(context).iconTheme.color!.withOpacity(.4)),
              ),
              const SizedBox(height: kDefaultPadding2x),
            ],
          ),
        );
      },
    );
  }
}
