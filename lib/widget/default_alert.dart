import 'package:crack_the_roll/common/constant.dart';
import 'package:flutter/material.dart';

class DefaultAlert extends StatelessWidget {
  final String title;
  final String content;
  const DefaultAlert({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kSecondaryColor,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black,
            ),
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }
}
