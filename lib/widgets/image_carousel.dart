import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/widgets/ContentSlider.dart';

final List imgList = [
  [
    "images/clang.png",
    "El lenguaje de programación C es es un lenguaje que a dia de hoy seguimos usando, incluso sin darnos cuenta. Muchos de los sistemas operativos, así como librerias y paquetes estándar están escritos en el ",
    Colors.blue
  ],
  [
    "images/jslang.png",
    "El lenguaje de programación javascript es el rey indiscutible de la programación web frontend, debido a sus abstracciones y librerias estándar que hacen que sea realmente fácil y rápido crear ui y funcionalidades",
    Colors.yellow
  ],
  [
    "images/hasklang.png",
    "Haskell es un lenguaje de programación funcional con evaluación floja, su paradigma se basa en la idea de los calculos lambda",
    Colors.deepPurple
  ]
];

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imgList
          .map((item) => Builder(builder: (context) {
                return Container(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push<Widget>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentSlider(
                              image: item[0],
                              content: item[1],
                              color: item[2],
                            ),
                          ),
                        );
                      },
                      child: Center(child: Image.asset(item[0].toString()))),
                );
              }))
          .toList(),
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }
}
