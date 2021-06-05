import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

customFlashBar(BuildContext context, String text) {
  return showFlash(
    context: context,
    duration: Duration(seconds: 2),
    builder: (context, controller) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Flash(
          controller: controller,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text(text),
          ),
        ),
      );
    },
  );
}
