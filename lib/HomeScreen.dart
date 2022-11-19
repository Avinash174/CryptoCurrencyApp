import 'dart:convert';
import 'package:cryto_currency_app/app_theme.dart';
import 'package:cryto_currency_app/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cryto_currency_app/coin_details_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=INR&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  String name = "", age = " ", email = "";
  bool isDarkMode = AppTheme.isDarkModenabled;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    getUserDetails();
    getCoinDetails();
  }

  void getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name') ?? " ";
      email = preferences.getString('email') ?? " ";
      age = preferences.getString('age') ?? " ";
    });
  }

  Future<List<CoinDetailsModel>> getCoinDetails() async {
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List coinsData = json.decode(response.body);

      List<CoinDetailsModel> data =
          coinsData.map((e) => CoinDetailsModel.fromJson(e)).toList();
      return data;
    } else {
      return <CoinDetailsModel>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: (IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        )),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Crpto Currency App",
          style: TextStyle(color: Colors.black),
        ),
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
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                setState(() {
                  isDarkMode = !isDarkMode;
                });
                AppTheme.isDarkModenabled = isDarkMode;
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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  hintText: "Search For Coin",
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getCoinDetails(),
                  builder: (context,
                      AsyncSnapshot<List<CoinDetailsModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return coinDetails(snapshot.data![index]);
                          });
                    } else {
                      return Center(
                        child: Text("Error Occured"),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget coinDetails(CoinDetailsModel model) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Image.network(
          model.image,
        ),
      ),
      title: Text(
        "${model.name}\n${model.symbol}",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
      trailing: RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          text: "RS.${model.currentPrice}",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: "${model.priceChangePercentage24h}%",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
