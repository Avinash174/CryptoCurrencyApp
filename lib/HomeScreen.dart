import 'package:cryto_currency_app/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "", age = " ", email = "";
  bool isDarkMode = false;

  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name') ?? " ";
      email = preferences.getString('email') ?? " ";
      age = preferences.getString('age') ?? " ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text("Crpto Currency App"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Name:$name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              accountEmail: Text(
                "Email: $email\nAge: $age",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              currentAccountPicture: Icon(
                Icons.account_circle,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 70,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UpdateProfileScreen()));
              },
              leading: Icon(
                Icons.account_box,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text(
                "Update Profile",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
            ListTile(
              onTap: () async{
                SharedPreferences prefs=await SharedPreferences.getInstance();

                setState(() {
                  isDarkMode = !isDarkMode;
                });
                await prefs.setBool('isDarkMode', isDarkMode);
              },
              leading: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text(
                isDarkMode ? "Light Mode" : "Dark Mode",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
