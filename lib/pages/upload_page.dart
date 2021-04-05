import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hellomnist/dl_model/classifier.dart';
import 'package:hellomnist/size_config.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final picker = ImagePicker();
  Classifier classifier = Classifier();
  PickedFile image;
  int digit = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          FluentIcons.image_add_24_regular,
          color: Colors.white,
        ),
        onPressed: () async {
          image = await picker.getImage(source: ImageSource.gallery);
          digit = await classifier.classifyImage(image);
          setState(() {});
        },
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Digit Recognizer',
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(24),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            digit == -1
                ? InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          FluentIcons.add_20_regular,
                          size: getProportionateScreenWidth(70),
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text(
                          'Open Image',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Colors.black, width: 2),
                          color: Colors.white,
                          image: DecorationImage(
                              image: FileImage(File(image.path))),
                        ),
                        height: getProportionateScreenHeight(300),
                        width: getProportionateScreenHeight(300),
                      ),
                      Divider(color: Colors.grey,),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Predicition',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "$digit",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(32),
                              fontWeight: FontWeight.w800,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
