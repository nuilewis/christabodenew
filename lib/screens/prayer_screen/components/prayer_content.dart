import 'package:christabodenew/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../core/date_time_formatter.dart';
import '../../../models/prayer_model.dart';
import '../../../models/settings_model.dart';
import '../../devotional_screen/components/next_previous_button.dart';

class PrayerContent extends StatelessWidget {
  final Prayer prayer;
  final VoidCallback onNextButtonPressed;
  final VoidCallback onPreviousButtonPressed;
  final VoidCallback onShareButtonPressed;
  final VoidCallback onLikedButtonPressed;
  const PrayerContent(
      {Key? key,
      required this.prayer,
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
              //color: Colors.trans,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(kDefaultPadding2x),
              //   topRight: Radius.circular(kDefaultPadding2x),
              // )
              ),
          padding: const EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: Column(
            children: [
              //Misters Name and actions

              Row(
                children: [
                  Text(
                    "${dateTimeFormatter(context, prayer.date)} to ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  // IconButton(
                  //   onPressed: onShareButtonPressed,
                  //   icon: SvgPicture.asset(
                  //     "assets/svg/share_icon.svg",
                  //     color: Theme.of(context).iconTheme.color!.withOpacity(.9),
                  //   ),
                  // ),
                  IconButton(
                    onPressed: onLikedButtonPressed,
                    icon: SvgPicture.asset(
                      prayer.isLiked
                          ? "assets/svg/heart_icon_filled.svg"
                          : "assets/svg/heart_icon.svg",
                      color: Theme.of(context).iconTheme.color!.withOpacity(.9),
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
                      color: Theme.of(context).iconTheme.color!.withOpacity(.9),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(prayer.scripture,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(prayer.scriptureReference)),

              const SizedBox(
                height: kDefaultPadding2x,
              ),
              Text(
                prayer.content,
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
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
