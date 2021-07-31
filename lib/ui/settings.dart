import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            title: Text("About App"),
            onTap: () {
              showAboutDialog(context: context);
            },
          )
        ]),
      ),
    );
  }
}
