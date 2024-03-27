import 'package:flutter/material.dart';
import 'package:social_media_clone/common/constants.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  const CustomAppbar({super.key, this.title, this.iconColor = Colors.black});
  final String? title;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Constants.secondaryColor,
      ),
      leading: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios, color: Constants.secondaryColor),
      ),
      title: Text(title ?? ""),
    );
  }
}
