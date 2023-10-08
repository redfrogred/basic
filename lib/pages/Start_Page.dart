// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../providers/Controller.dart';

class Start_Page extends StatefulWidget {
  const Start_Page({ super.key });

  @override
  State createState() => _Start_PageState();
}

class _Start_PageState extends State<Start_Page> {

  _Start_PageState() {
    Utils.log( 'Start_Page.dart', '[[ init "${ Config.appName }" version ${ Config.appVersion } ]]' );
  }

  // (this page) variables
  static const String _fileName = 'Start_Page.dart';
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log( _fileName, 'initState()' );
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));

    //  init the app
    WidgetsBinding.instance.addPostFrameCallback((_) => _init(context));    
  }

  @override
  void dispose() {
    Utils.log( _fileName, 'dispose()');
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log( _fileName, '_buildTriggered()');
  }
  

  void _init( context ) {
    //  this is called from initState in "Start_Page.dart"...
    //  If it is the first time ever, it will do some housekeeping
    //  with Controller.initApp()
    Provider.of<Controller>(context, listen: false).initApp();
  }

  void _addPostFrameCallbackTriggered( context ) {
    Utils.log( _fileName, '_addPostFrameCallbackTriggered()');
  }

  // (this page) build
  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        return true;  //  this allows the back button to work
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,  
            //  backgroundColor: Config.mainBackgroundColor,
            appBar: AppBar(
              title: const Text( _fileName ),
              centerTitle: true,
            ), //AppBar
            // drawer: DrawerWidget(),
            body: Container(
              color: Colors.transparent,
              child: Center(
                child: ElevatedButton(
                  child: Text( 'End_Page() >>' ),
                  onPressed: () {
                    Utils.log( _fileName, 'go to End_Page()');
                    Future.delayed( Duration(milliseconds: Config.shortDelay ), () async {
                      Navigator.of(context).pushNamed('End_Page');         
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