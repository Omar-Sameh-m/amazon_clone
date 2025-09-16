import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double smallAdhieght = screenSize.height * 0.15;
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == largeAds.length - 1) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(largeAds[currentAd], width: double.infinity),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [backgroundColor, backgroundColor.withOpacity(0)],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: backgroundColor,
            width: screenSize.width,
            height: smallAdhieght,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getSmallAdsFromIndex(0, smallAdhieght),
                getSmallAdsFromIndex(1, smallAdhieght),
                getSmallAdsFromIndex(2, smallAdhieght),
                getSmallAdsFromIndex(3, smallAdhieght),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget getSmallAdsFromIndex(int index, double height) {
  return Container(
    width: height,
    height: height,
    decoration: ShapeDecoration(
      color: Colors.white,
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.network(smallAds[index]), Text(adItemNames[index])],
    ),
  );
}
