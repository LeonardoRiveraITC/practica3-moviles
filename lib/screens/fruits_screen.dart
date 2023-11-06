import 'package:flutter/material.dart';
import 'package:pmsn20232/widgets/image_carousel.dart';
import 'package:pmsn20232/widgets/counter.dart';

class FruitsScreen extends StatefulWidget {
  const FruitsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return FruitsScreenState();
  }
}

class FruitsScreenState extends State<FruitsScreen> {
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  //expandir carrusil y desplegar info en hero
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 800),
          child: CarouselWithIndicatorDemo(),
        ),
      ),
    );
  }
}
