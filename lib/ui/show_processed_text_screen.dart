import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ShowProcessedText extends StatefulWidget {
  final RecognisedText text;
  const ShowProcessedText(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  _ShowProcessedTextState createState() => _ShowProcessedTextState();
}

class _ShowProcessedTextState extends State<ShowProcessedText> {
  TextEditingController textController = TextEditingController();
  void exportToPdf() async {
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textController,
                    decoration:
                        InputDecoration(hintText: 'Type file Name Here'),
                  ),
                  TextButton(
                      onPressed: () {
                        fileName = textController.text;
                        Navigator.pop(context);
                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          );
        });
    if (fileName == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error generating pdf!!")));
      return;
    }
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
      widget.text.text,
      PdfCjkStandardFont(PdfCjkFontFamily.hanyangSystemsGothicMedium, 30),
    );

    final bytes = document.save();
    document.dispose();
    saveToStorage(bytes);
  }

  String? fileName;

  void saveToStorage(List<int> bytes) async {
    final path = await createFolder();
    final file = File('${path}$fileName.pdf');
    await file.writeAsBytes(bytes, flush: true);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Exported to Pdf!")));
    //done saving file
  }

  Future<String> createFolder() async {
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory('${_appDocDir.path}/pdfs/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: exportToPdf, icon: Icon(Icons.file_copy))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SelectableText(this.widget.text.text),
        ),
      ),
    );
  }
}
