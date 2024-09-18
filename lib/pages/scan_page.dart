import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  static const String routename='/scan';
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanOver= false;
  List<String> lines=[];
  String name='',mobile='',email='',address='', company='', designation='',website='',image='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),

      ),
      body:ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: (){
                  getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Capture'),
              ),
              TextButton.icon(
                onPressed: (){
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo_album),
                label: const Text('Gallery'),
              )
            ],
          ),
          Wrap(
            children: lines.map((line)=> Chip(label: Text(line),)).toList(),
          )
        ],
      ) ,
    );
  }

  void getImage(ImageSource source) async{
    final xFile= await ImagePicker().pickImage(source: source);
    if(xFile!= null)
      {
        image= xFile.path;
        final textRecognizer= TextRecognizer(script: TextRecognitionScript.latin);
        final recognizedText= await textRecognizer
            .processImage(InputImage.fromFile(File(image)));
        final tempList= <String>[];
        for(var block in recognizedText.blocks){
          for(var line in block.lines){
            tempList.add(line.text);
          }
        }
        setState(() {
          lines= tempList;
          isScanOver=true;
        });
      }
  }
}
