import 'package:flutter/material.dart';
import 'dart:io';

class BackButtonCustom extends StatelessWidget {
  BuildContext pageCtx;

  BackButtonCustom(this.pageCtx);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(pageCtx).pop();
      },
      child: Icon(
        Platform.isAndroid
            ? Icons.keyboard_backspace
            : Icons.chevron_left_rounded,
        color: Colors.black.withOpacity(1),
        size: 40,
      ),
    );
  }
}