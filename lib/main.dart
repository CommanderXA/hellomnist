import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellomnist/pages/upload_page.dart';
import 'package:hellomnist/size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        fontFamily: 'OpenSans',
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List tabs = [
    UploadImage(),
    Center(child: Text("Drawing page"))
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white, //Nav bar
      systemNavigationBarIconBrightness: Brightness.dark,
    )); 
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(icon: Icon(FluentIcons.image_20_regular), label: "Image", activeIcon: Icon(FluentIcons.image_20_filled),),
          BottomNavigationBarItem(icon: Icon(FluentIcons.edit_20_regular), label: "Draw", activeIcon: Icon(FluentIcons.edit_20_filled),),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
