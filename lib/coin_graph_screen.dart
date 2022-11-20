import 'package:cryto_currency_app/HomeScreen.dart';
import 'package:flutter/material.dart';

class CoinScreenGraph extends StatefulWidget {
  final String coinId, coiName;
  const CoinScreenGraph({Key? key, required this.coinId, required this.coiName})
      : super(key: key);

  @override
  State<CoinScreenGraph> createState() => _CoinScreenGraphState();
}

class _CoinScreenGraphState extends State<CoinScreenGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          widget.coiName,
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            RichText(text: TextSpan())
          ],
        ),
      ),
    );
  }
}
