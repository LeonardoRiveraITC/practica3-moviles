import 'package:flutter/material.dart';
import 'package:pmsn20232/network/api_popular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopoular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular=ApiPopoular();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(title:Text('Popoular movies'),),
       body: FutureBuilder(
        future:apiPopular!.getAllPopular(),
        builder:(context,snapshot){
          return Text('hola');
        }
       ),
    );
  }
}