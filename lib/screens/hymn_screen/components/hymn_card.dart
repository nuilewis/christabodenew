import 'package:christabodenew/core/extensions/string_extension.dart';
import 'package:christabodenew/models/hymn_model.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class HymnCard extends StatelessWidget {
  final Hymn hymn;

  const HymnCard({
    super.key,
    required this.hymn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(kDefaultPadding + 8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(hymn.number.toString(),
                style: Theme.of(context).textTheme.bodyLarge),
            Text(hymn.title.toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge),

          ],
        ),
      ),
    );
  }
}
