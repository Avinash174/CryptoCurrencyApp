import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({Key? key}) : super(key: key);

  final TextEditingController name=TextEditingController();
   final TextEditingController age=TextEditingController();
   final TextEditingController email=TextEditingController();

  Future<void> saveDate(String key,value) async{
    SharedPreferences _pref =await SharedPreferences.getInstance();
    await _pref.setString(key, value);
  }

  void saveUserDetails()async{
   await saveDate('name', name.text);
   await saveDate('email', email.text);
   await saveDate('age', age.text);
   print("Data Save");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        centerTitle: true
      ),
      body: Column(
        children: [
          customTextFiek("Name ",name,false),
          customTextFiek("Age", age,true),
          customTextFiek("Email ",email,false),
          ElevatedButton(onPressed: (){saveUserDetails();
            }, child: Text("Save Details"),),
        ],
      ),
    );
  }
}
Widget customTextFiek(String hintText,TextEditingController controller,bool isTextField){
  return Padding(padding: EdgeInsets.all(15.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      keyboardType: isTextField? TextInputType.number:null,
    ),
  );
}
