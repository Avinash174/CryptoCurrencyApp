import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crpto Currency App"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              accountEmail: Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              currentAccountPicture: Icon(
                Icons.account_circle,
                size: 70,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: (){

              },
              leading: Icon(Icons.account_box),
              title: Text(
                  "Update Profile",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
