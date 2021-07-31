import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition/ui/show_processed_text_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? currentImage;
  String? currentPath;

  void getImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      //no image picked
      return;
    }
    currentImage = await file.readAsBytes();
    currentPath = file.path;
    setState(() {});
  }

  void getImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) {
      //no image picked
      return;
    }
    currentImage = await file.readAsBytes();
    currentPath = file.path;
    setState(() {});
  }

  void reset() {
    currentImage = null;
    currentPath = null;
    setState(() {});
  }

  void processImage() async {
    if (currentPath == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No Image Selected!")));
      return;
    }
    try {
      final inputImage = InputImage.fromFilePath(currentPath!);
      final textDetector = GoogleMlKit.vision.textDetector();
      final recognisedText = await textDetector.processImage(inputImage);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ShowProcessedText(recognisedText);
      }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: devSize.height * .3,
              width: devSize.width * .5,
              color: Colors.white,
              child: Center(
                child: currentImage == null
                    ? Text("No Image Selected")
                    : Image.memory(currentImage!),
              ),
            ),
            TextButton(
                onPressed: getImageFromGallery,
                child: Text("Get Image from Gallery")),
            TextButton(
                onPressed: getImageFromCamera,
                child: Text("Get Image from Camera")),
            TextButton(onPressed: reset, child: Text("Reset")),
            TextButton(onPressed: processImage, child: Text("Process Image"))
          ],
        ));
  }
}
