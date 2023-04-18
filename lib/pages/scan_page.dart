import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static const String routeName= '/scan';
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<String> lines= [];
  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      designation = '',
      website = '',
      image = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Card"),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(onPressed: (){
                getImage(ImageSource.camera);
              }, icon: const Icon(Icons.camera), label: const Text("Capture")),
              TextButton.icon(onPressed: (){
                getImage(ImageSource.gallery);
              }, icon: const Icon(Icons.photo_album), label: const Text("Gallery")),
            ],
          ),
          Wrap(
            children: lines.map((line) => LineItem(line: line,)).toList(),
          )
        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source) async{
    final pickedFile  = await ImagePicker().pickImage(source: source);
    if(pickedFile !=null){
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final recognizedText = await textRecognizer
          .processImage(InputImage.fromFile(File(pickedFile.path)));
      // setState(() {
      //   isScanOver = true;
      // });
      final tempList = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }
      print(tempList);
      setState(() {
        lines = tempList;
      });
    }
  }
}


class LineItem extends StatelessWidget {
  final String line;
  const LineItem({Key? key,required this.line}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey _globalKey = GlobalKey();

    return LongPressDraggable<String>(
      data: line,
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Container(
        key: _globalKey,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black45,
        ),
        child: Text(line,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white)),
      ),
      child: Chip(
        label: Text(line),
      ),
    );
  }
}

