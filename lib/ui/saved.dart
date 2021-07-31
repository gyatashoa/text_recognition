import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    getSavedFiles();
  }

  List<FileSystemEntity>? files;

  void getSavedFiles() async {
    final path = await getFolder();
    if (path == null) {
      //folder not created
      return;
    }
    final dir = Directory(path);
    files = dir.listSync();
    setState(() {});
  }

  Future<String?> getFolder() async {
    //Get this App Document Directory
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory('${_appDocDir.path}/pdfs/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    }
  }

  void onFilePressed(FileSystemEntity entity) async {
    var res = await OpenFile.open(entity.path);
    if (res.type == ResultType.done) {
      //file opened successfully
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: files == null
          ? Center(
              child: Text("No pdfs saved!"),
            )
          : ListView.builder(
              itemBuilder: (_, i) {
                var chunks = files![i].path.split("/");
                String name = chunks.last;
                return ListTile(
                  title: Text(name),
                  onTap: () => onFilePressed(files![i]),
                );
              },
              itemCount: files!.length,
            ),
    );
  }
}
