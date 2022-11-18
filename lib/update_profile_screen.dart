import 'package:cryto_currency_app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController email = TextEditingController();

  Future<void> saveDate(String key, value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString(key, value);
  }

  void saveUserDetails() async {
    await saveDate('name', name.text);
    await saveDate('email', email.text);
    await saveDate('age', age.text);
    print("Data Save");
  }

  bool isDarkModeEnabled = AppTheme.isDarkModenabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkModeEnabled ? Colors.black : Colors.white,
      appBar: AppBar(

          title: Text("Update Profile"),
          centerTitle: true),
      body: Column(
        children: [
          customTextField("Name ", name, false),
          customTextField("Age", age, true),
          customTextField("Email ", email, false),
          ElevatedButton(
            onPressed: () {
              saveUserDetails();
            },
            child: Text("Save Details"),
          ),
        ],
      ),
    );
  }

  Widget customTextField(
      String hintText, TextEditingController controller, bool isTextField) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkModeEnabled ? Colors.white : Colors.grey,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDarkModeEnabled ? Colors.white : Colors.black,
          ),
        ),
        keyboardType: isTextField ? TextInputType.number : null,
      ),
    );
  }
}
