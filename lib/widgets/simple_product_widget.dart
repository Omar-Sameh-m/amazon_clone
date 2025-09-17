import 'package:flutter/material.dart';

class SimpleProductWidget extends StatelessWidget {
  const SimpleProductWidget({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Image.network(url),
        ),
      ),
    );
  }
}
