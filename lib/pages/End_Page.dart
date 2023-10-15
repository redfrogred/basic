// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';

class End_Page extends StatelessWidget {
  const End_Page({super.key});

  //  (this page) variables
  static const String _filename = 'End_Page.dart';  

  @override
  Widget build(BuildContext context) {
    Utils.log( _filename, 'initialized' );
    return WillPopScope(
      onWillPop: () async {
        //  is back button allowed?    
        Utils.log( _filename, 'pop() from AppBar');    
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,  
          //  backgroundColor: Config.mainBackgroundColor,
          appBar: AppBar(
            title: const Text( _filename ),
            centerTitle: true,
          ), 
          //  drawer: Drawer_Widget(),
          body: Container(
              color: Colors.transparent,
              child: Center(
                child: ElevatedButton(
                  child: const Text( '<< Start_Page()' ),
                  onPressed: () {
                    Utils.log( _filename, 'pop() from body');
                    Future.delayed( Duration(milliseconds: Config.short_delay ), () async {
                      Navigator.of(context).pop();
                      //  if I didn't use "pop" here, and instead used
                      //  Navigator.of(context).pushNamed('Start_Page')
                      //  then Start would be added to the navigation 
                      //  stack.
                      return;
                    }); 
                  },
                ),  
              ),
            ),
        ),
      ),
    );
  }
}