import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          customTextField('Name'),
          customTextField("Email"),
        ],
      ),
    );
  }
}

Widget customTextField(String title) {
  return Padding(
    padding: EdgeInsets.all(15.0),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintStyle: title,
        
      ),
    ),
  );
}
