// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];

  void selectImage() async {
    final List<XFile>? selectImages = await _picker.pickMultiImage();
    try {
      if (selectImages!.isNotEmpty) {
        _imageFileList!.addAll(selectImages);
      }else{
        print("gagal");
      }
    } catch (e) {
      print("gagal");
    }

    print("Image List Length : ${_imageFileList!.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: OutlinedButton(
                onPressed: () {
                  selectImage();
                },
                child: Text("Select Images")),
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: _imageFileList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(_imageFileList![index].path),
                      fit: BoxFit.cover,
                    );
                  }))
        ],
      )),
    );
  }
}
