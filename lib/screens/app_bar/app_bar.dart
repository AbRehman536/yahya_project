import 'package:flutter/material.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("App Bar", style: TextStyle(
          color: Colors.amber,
          fontSize: 20.5,
          fontWeight: FontWeight.w900,
          decoration: TextDecoration.underline,
          decorationColor: Colors.amber,
          decorationStyle: .dotted,
          height: 20,
          letterSpacing: 2,
          wordSpacing: 4,
          fontStyle: FontStyle.italic
        ),),
        centerTitle: true,
        leading: Icon(Icons.menu,color: Colors.black,size: 30,),
        actions: [
          Icon(Icons.favorite,color: Colors.red,),
          Icon(Icons.search,color: Colors.green,),
          Icon(Icons.bookmark,color: Colors.yellow,),
        ],
      ),
    );
  }
}
