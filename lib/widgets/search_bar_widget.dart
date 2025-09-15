import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;

  const SearchBarWidget({
    super.key,
    required this.isReadOnly,
    required this.hasBackButton,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    );
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back))
              : Container(),

          SizedBox(
            width: screenSize.width * 0.7,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for something in amazon.com',
                fillColor: Colors.white,
                filled: true,
                border: outlineBorder,
                focusedBorder: outlineBorder,
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.mic_outlined)),
        ],
      ),
    );
  }
}
