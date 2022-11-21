import 'package:cryto_currency_app/HomeScreen.dart';
import 'package:fl_chart/fl_chart.dart';
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: "${widget.coiName} Price\n",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "RS.1806052.09\n",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "2.735346\n",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: "RS.298373.90\n",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  minX:0 ,
                  minY:0 ,
                  maxX: 10,
                  maxY: 20,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(1, 5),
                        FlSpot(5, 5.3),
                        FlSpot(6, 3.5),
                        FlSpot(5.2, 9.2),
                        FlSpot(1.23, 18.6),
                        FlSpot(6.8, 15.7),
                        FlSpot(9.5, 10),
                        FlSpot(8.2, 1),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
