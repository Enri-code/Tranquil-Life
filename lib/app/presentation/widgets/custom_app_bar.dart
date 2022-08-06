import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';

class AppBarAction {
  final Widget icon;
  final bool isCustomButton;
  final Function()? onPressed;

  AppBarAction({
    required this.icon,
    required this.onPressed,
    this.isCustomButton = true,
  });
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final List<AppBarAction>? actions;
  final bool isStatusBarDark;
  final Function()? onBackPressed;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.isStatusBarDark = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness:
            isStatusBarDark ? Brightness.dark : Brightness.light,
        statusBarBrightness:
            isStatusBarDark ? Brightness.light : Brightness.dark,
      ),
      leading: (Navigator.of(context).canPop()) || onBackPressed != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: AppBarButton(
                  onPressed: onBackPressed ?? Navigator.of(context).pop,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            )
          : null,
      title: title != null
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 21,
                  color: ColorPalette.primary[800],
                ),
              ),
            )
          : null,
      actions: actions?.map<Widget>((e) {
        if (e.isCustomButton) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: AppBarButton(icon: e.icon, onPressed: e.onPressed),
            ),
          );
        }
        return IconButton(onPressed: e.onPressed, icon: e.icon);
      }).toList()
        ?..add(const SizedBox(width: 4)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
