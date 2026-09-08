import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Small popup menu for a dish.
///
/// [globalPosition] is the real position of the More button on the screen.
/// The menu is converted to a RelativeRect so Flutter can place it next to
/// that specific dish instead of using a fixed/centered position.
class DishMoreMenu {
  DishMoreMenu._();

  static Future<void> show({
    required BuildContext context,
    Offset? globalPosition,
    RelativeRect? position,
    VoidCallback? onAddToCalendar,
    VoidCallback? onRemoveFromFavorites,
    VoidCallback? onShare,
    String favoriteLabel = 'Remove from Favorites',
    String calendarLabel = 'Add to Calendar',
  }) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect menuPosition;

    if (globalPosition != null) {
      menuPosition = RelativeRect.fromRect(
        Rect.fromCenter(
          center: globalPosition,
          width: 1,
          height: 1,
        ),
        Offset.zero & overlay.size,
      );
    } else if (position != null) {
      menuPosition = position;
    } else {
      throw ArgumentError(
        'Either globalPosition or position must be provided.',
      );
    }

    final selected = await showMenu<String>(
      context: context,
      position: menuPosition,
      color: AppColors.background,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      items: [
        _buildMenuItem(
          value: 'calendar',
          icon: calendarLabel == 'Add to Calendar' ? Icons.add : Icons.remove,
          label: calendarLabel,
        ),
        _buildMenuItem(
          value: 'favorites',
          icon: favoriteLabel == 'Remove from Favorites'
              ? Icons.favorite_border
              : Icons.favorite,
          label: favoriteLabel,
        ),
        _buildMenuItem(
          value: 'share',
          icon: Icons.share_outlined,
          label: 'Share',
        ),
      ],
    );

    switch (selected) {
      case 'calendar':
        onAddToCalendar?.call();
        break;
      case 'favorites':
        onRemoveFromFavorites?.call();
        break;
      case 'share':
        onShare?.call();
        break;
    }
  }

  static PopupMenuItem<String> _buildMenuItem({
    required String value,
    required IconData icon,
    required String label,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: 44,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.textPrimary,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyles.categoryItem,
          ),
        ],
      ),
    );
  }
}
