import 'package:flutter/material.dart';
import 'package:pmsn20232/widgets/counter.dart';

class ContentSlider extends StatelessWidget {
  final String? image;
  final String? content;
  final Color? color;
  const ContentSlider(
      {Key? key,
      required this.image,
      required this.content,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "imageHero",
        child: Container(
          color: color,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(image.toString()),
              Center(
                child: Text(
                  content.toString(),
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ));
  }
}
