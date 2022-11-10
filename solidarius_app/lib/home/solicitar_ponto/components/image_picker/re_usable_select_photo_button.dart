import 'package:flutter/material.dart';
import 'package:solidarius_app/theme/app_theme.dart';

class SelectPhoto extends StatelessWidget {
  final String textLabel;
  final IconData icon;

  final void Function()? onTap;

  const SelectPhoto({
    Key? key,
    required this.textLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: AppTheme.nearlyWhite,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              icon,
              color: AppTheme.nearlyPurple,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              textLabel,
              style: const TextStyle(
                fontSize: 18,
                color: AppTheme.nearlyPurple,
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
