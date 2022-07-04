import 'package:flutter/material.dart';

class FindLocationView extends StatelessWidget {
  const FindLocationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,        
        height: MediaQuery.of(context).size.height,        
      ),
    );
  }
}