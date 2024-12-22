import 'package:flutter/material.dart';
import '../../core/config/color_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
        this.title,
        this.elevation = 0,
        this.centerTitle = true,
        this.onBackTap,
        this.onHomeBtnPressed,
        this.isBackIconVisible = true,
        this.tabBar,
        this.isUnderLine = false,
        this.isHamburgerMenuEnable = false,
        this.backgroundColor = Colors.white,
        this.isNotificationEnable = false,
        this.isQrEnable = false,
        this.qrOnclick,
        this.isHomeEnable = false,
      });

  final String? title;
  final double? elevation;
  final bool centerTitle;
  final TabBar? tabBar;
  final bool isBackIconVisible;
  final Function()? onBackTap;
  final Function()? onHomeBtnPressed;
  final bool isUnderLine;
  final bool? isHamburgerMenuEnable;
  final bool? isNotificationEnable;
  final bool? isQrEnable;
  final Function()? qrOnclick;
  final bool? isHomeEnable;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: ColorConfig.textColorPrimary),
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      shadowColor: Colors.grey,
      elevation: elevation,
      centerTitle: centerTitle,
      bottom: tabBar,
      title: Text(
        title ?? '',
        style:  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ColorConfig.textColorPrimary,
            decoration: isUnderLine ? TextDecoration.underline : TextDecoration.none,
            height: 3
        ),
      ),
      leading: isBackIconVisible
          ?
      Visibility(visible: isBackIconVisible,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 35),
          onPressed: () async {
            if(onBackTap != null){ // go back
              await onBackTap!();
            }
            FocusManager.instance.primaryFocus?.unfocus(); // hide the keyboard
            Navigator.of(context).pop();
          },
        ),
      )
          :
      isHamburgerMenuEnable == true ? IconButton(onPressed: (){
        Scaffold.of(context).openDrawer();
      }, icon: const Icon(Icons.menu_outlined)):null,

      actions: [
        Row(
          children: [
            if (isNotificationEnable == true)
              IconButton(
                onPressed: () {
                  // context.push(RouterPath.notificationScreenPath);
                },
                icon: const Icon(Icons.notifications_active, color: ColorConfig.primaryColor),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, tabBar == null ? 50 : 78);
}
