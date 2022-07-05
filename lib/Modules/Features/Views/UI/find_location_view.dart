import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:javacode/Modules/Models/Hive/user_hive_model.dart';

class FindLocationView extends StatelessWidget {
  FindLocationView({Key? key}) : super(key: key);

  Box<User> box = Hive.box<User>('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(child: Text(box.values.length.toString())),
      ),
    );
  }
}
