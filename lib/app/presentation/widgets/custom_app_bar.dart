import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/text.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';

class AppBarAction {
  final Widget child;
  final bool isCustomButton;
  final Function()? onPressed;

  const AppBarAction({
    required this.child,
    this.onPressed,
    this.isCustomButton = true,
  });
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool hideBackButton;
  final Color? titleColor;
  final List<AppBarAction>? actions;
  final Function()? onBackPressed;

  const CustomAppBar({
    Key? key,
    this.title,
    this.titleColor,
    this.hideBackButton = false,
    this.actions,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: const Color(0x00ffffff),
      backgroundColor: Colors.transparent,
      toolbarTextStyle: TextStyle(
        fontSize: 17,
        color: ColorPalette.green[800],
        fontFamily: MyTextData.josefinFamily,
      ),
      leading: (Navigator.of(context).canPop() || onBackPressed != null) &&
              !hideBackButton
          ? Hero(
              tag: 'back_button',
              child: Center(
                child: AppBarButton(
                  onPressed: onBackPressed ?? Navigator.of(context).pop,
                  icon: const Padding(
                    padding: EdgeInsets.all(1),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 19,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      title: title != null
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 21,
                  color: titleColor ?? ColorPalette.green[800],
                ),
              ),
            )
          : null,
      actions: actions?.map<Widget>((e) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Center(
            child: e.isCustomButton
                ? AppBarButton(icon: e.child, onPressed: e.onPressed)
                : _NormalButton(e),
          ),
        );
      }).toList()
        ?..add(const SizedBox(width: 4)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NormalButton extends StatelessWidget {
  const _NormalButton(this.data, {Key? key}) : super(key: key);
  final AppBarAction data;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(color: ColorPalette.green[800], size: 24),
      ),
      child: GestureDetector(onTap: data.onPressed, child: data.child),
    );
  }
}
