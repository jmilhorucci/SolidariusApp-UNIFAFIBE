import 'package:flutter/material.dart';
import 'package:solidarius_app/theme/app_theme.dart';

class FullLoading {
  static Future<void> show(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppTheme.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
