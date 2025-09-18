import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class AccountscreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AccountscreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Image.network(amazonLogoUrl, height: kAppBarHeight * 0.8),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_outlined, color: Colors.black),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_outlined, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
