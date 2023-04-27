import 'package:flutter/material.dart';

class MutedText extends StatelessWidget {
  const MutedText(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Theme.of(context).hintColor),
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }
}
