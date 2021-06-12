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
          backgroundColor: Colors.black54.withOpacity(0.6),
          controller: controller,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.bottom,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 10),
              child: Center(
                  child: Text(
                text,
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      );
    },
  );
}
