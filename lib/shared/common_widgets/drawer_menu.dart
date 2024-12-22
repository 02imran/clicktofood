import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/utils/app_logs.dart';
import 'package:click_to_food/core/utils/pref_utils.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:flutter/material.dart';
import '../../core/config/asset_config.dart';
import '../../core/config/color_config.dart';
import '../../core/utils/size_config.dart';
import 'custom_image_view.dart';
import 'gap.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  var fullName = "";
  var email = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var fullNameD = await PrefUtils.getFullName();
    var emailD = await PrefUtils.getEmail();
    setState(() {
      fullName = fullNameD;
      email = emailD;
    });
    AppLogs.infoLog("fullName :: $fullName");
    AppLogs.infoLog("email :: $email");
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [

          buildUserProfile(context),

          buildMenuItem(
            context: context,
            icon: Icons.person_outline_rounded,
            title: "My Profile",
            isIconVisible: true,
            onTap: () {

            },
          ),

          buildMenuItem(
            context: context,
            icon: Icons.logout_rounded,
            title: "Logout",
            isIconVisible: true,
            onTap: () {

            },
          ),

        ],
      ),
    );
  }

  // User Profile Header
  Widget buildUserProfile(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ ColorConfig.primaryColor, ColorConfig.primaryColor.withOpacity(0.5),],
          begin: Alignment.topRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Row(
        children: [

          Container(
            decoration: BoxDecoration(
              color: ColorConfig.primaryColor.withOpacity(0.85),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(20),
            height: getProportionateScreenHeight(60),
            width: getProportionateScreenWidth(60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CustomImageView(
                imagePath: AssetConfig.user_icon,
                color: ColorConfig.whiteColor,
                fit: BoxFit.fill,
              ),
            ),
          ),

          const Gap(10, direction: Axis.horizontal,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(5),
              Text(StringConfig.appName, style: textSize18w600.copyWith(color: ColorConfig.whiteColor)),
              fullName.isEmpty ? const SizedBox() : Text(fullName, style: textSize14w600),
              email.isEmpty ? const SizedBox() : Text(email, style: textSize14w600.copyWith(color: ColorConfig.whiteColor)),
              // Text(provider.interestRate, style: textSize12.copyWith(color: ColorConfig.whiteColor, fontWeight: FontWeight.w400))
            ],
          )
        ],
      ),
    );

  }

  Widget buildMenuItem({required BuildContext context, required IconData icon, required String title, required VoidCallback onTap, bool isIconVisible = false}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }

}
