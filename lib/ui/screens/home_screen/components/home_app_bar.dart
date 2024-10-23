import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/image_utils.dart';

class HomeAppBar extends StatelessWidget {

  final VoidCallback onActionPress;

  const HomeAppBar({super.key, required this.onActionPress});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo
                SvgPicture.asset(
                  width: 48,
                  height: 48,
                  ImageUtils.APP_LOGO_SVG,
                  color: Theme.of(context).colorScheme.onSurface,
                ),

                // Notification Button
                IconButton(
                  iconSize: 24,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  icon: const Icon(Icons.notifications_none_rounded),
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: onActionPress,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
