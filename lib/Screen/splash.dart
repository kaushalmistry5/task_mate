import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/Screen/addtaskscrn.dart';

import 'package:todo/Screen/homescrn.dart';
import 'package:todo/service/local_db/database_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      db.database;
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> HomeScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: SvgPicture.asset("asset/images/splashscrn.svg")
      ),
    );
  }
}