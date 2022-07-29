import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool hideBackButton;
  final bool isStatusBarDark;
  final Function()? onBackPressed;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.hideBackButton = false,
    this.isStatusBarDark = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness:
            isStatusBarDark ? Brightness.dark : Brightness.light,
        statusBarBrightness:
            isStatusBarDark ? Brightness.light : Brightness.dark,
      ),
      leading: (Navigator.of(context).canPop() && !hideBackButton) ||
              onBackPressed != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: GestureDetector(
                  onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : null,
      title: title != null
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                title!,
                style: const TextStyle(fontSize: 24),
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
