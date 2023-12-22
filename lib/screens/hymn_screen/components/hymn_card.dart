import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:christabodenew/models/hymn_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants.dart';

class HymnCard extends StatelessWidget {
  final Hymn hymn;
  final VoidCallback onPressed;

  const HymnCard({
    super.key,
    required this.hymn, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashFactory: InkSparkle.splashFactory,
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
        onTap: onPressed,
        child: Ink(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Hymn ${hymn.number.toString()}",
                  style: Theme.of(context).textTheme.bodyLarge),
              const Gap(16),
              Text(hymn.title.toTitleCase(),
                  style: Theme.of(context).textTheme.bodyLarge),

            ],
          ),
        ),
      ),
    );
  }
}
