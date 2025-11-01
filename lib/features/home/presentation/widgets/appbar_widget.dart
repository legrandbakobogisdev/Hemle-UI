import 'package:flutter/material.dart';
import 'package:hemle/config/colors/appColors.dart';
import 'package:hemle/features/splashscreen/presentation/widgets/language_selector.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool showBackButton;
  final bool showLanguageSelector;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final Color backgroundColor;
  final Color titleColor;
  final double elevation;
  final bool centerTitle;
  final double? height;
  final Widget? leading;
  final double titleSpacing;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showLanguageSelector = true,
    this.actions,
    this.onBackPressed,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.elevation = 0,
    this.centerTitle = false,
    this.leading,
    this.height,
    this.titleSpacing = 0,
  });

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: false,
      foregroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      leading: _buildLeading(context),
      title: _buildTitle(),
      actions: _buildActions(),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    
    if (showBackButton) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        color: titleColor,
        onPressed: onBackPressed ?? () => Navigator.pop(context),
      );
    }
    return null;
  }

  Widget _buildTitle() {
    return title;
  }

  List<Widget> _buildActions() {
    final List<Widget> actionWidgets = [];

    // Ajouter les actions personnalisées
    if (actions != null) {
      actionWidgets.addAll(actions!);
    }

    // Ajouter le sélecteur de langue si demandé
    if (showLanguageSelector) {
      actionWidgets.add(
        LanguageSelector(
          iconColor: titleColor,
        ),
      );
      actionWidgets.add(const SizedBox(width: 8));
    }

    return actionWidgets;
  }
}