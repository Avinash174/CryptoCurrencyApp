import 'dart:convert';
import 'package:cryto_currency_app/HomeScreen.dart';
import 'package:cryto_currency_app/app_theme.dart';
import 'package:cryto_currency_app/coin_details_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoinScreenGraph extends StatefulWidget {
  final CoinDetailsModel coinDetailsModel;
  const CoinScreenGraph({Key? key, required this.coinDetailsModel})
      : super(key: key);

  @override
  State<CoinScreenGraph> createState() => _CoinScreenGraphState();
}

class _CoinScreenGraphState extends State<CoinScreenGraph> {
  bool isLoading = true,
      isFirstTime = true,
      isDarkMode = AppTheme.isDarkModenabled;
  List<FlSpot> flSpotList = [];
  double minX = 0.0, minY = 0.0, maxX = 0.0, maxY = 0.0;
  void initState() {
    super.initState();
    getChartData("1");
  }

  void getChartData(String days) async {
    if (isFirstTime) {
      isFirstTime = false;
    } else {
      setState(() {
        isLoading = true;
      });
    }
    String apiUrl =
        "https://api.coingecko.com/api/v3/coins/${widget.coinDetailsModel.id}/market_chart?vs_currency=inr&days=$days";
    Uri uri = Uri.parse(apiUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map<String, dynamic> result = json.decode(response.body);

      List rawList = result['prices'];
      List<List> chartData = rawList.map((e) => e as List).toList();
      List<PriceAndTime> priceAndTimeList = chartData
          .map((e) => PriceAndTime(time: e[0] as int, price: e[1] as double))
          .toList();
      flSpotList = [];
      for (var element in priceAndTimeList) {
        flSpotList.add(FlSpot(element.time.toDouble(), element.price));
      }
      minX = priceAndTimeList.first.time.toDouble();
      maxX = priceAndTimeList.last.time.toDouble();
      priceAndTimeList.sort((a, b) => a.price.compareTo(b.price));
      minY = priceAndTimeList.first.price;
      maxY = priceAndTimeList.last.price;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  isDarkMode?Colors.black:Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
                color: isDarkMode?Colors.white:Colors.black
            )),
        title: Text(
          widget.coinDetailsModel.name,
          style: TextStyle(color: isDarkMode?Colors.white:Colors.black, fontSize: 22),
        ),
        backgroundColor: isDarkMode?Colors.black:Colors.white,
        elevation: 0,
        centerTitle: true,

      ),
      body: isLoading == false
          ? SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: "${widget.coinDetailsModel.name} Price\n",
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkMode?Colors.white:Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "RS.${widget.coinDetailsModel.currentPrice}\n",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                    color: isDarkMode?Colors.white:Colors.black

                                ),
                              ),
                              TextSpan(
                                text:
                                    "${widget.coinDetailsModel.priceChangePercentage24h}\n",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: "RS.$maxY\n",
                                style: TextStyle(
                                  fontSize: 16,
                                    color: isDarkMode?Colors.white:Colors.black
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                        minX: minX,
                        minY: minY,
                        maxX: maxX,
                        maxY: maxY,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        titlesData: FlTitlesData(
                          show: false,
                        ),
                        gridData: FlGridData(getDrawingVerticalLine: (value) {
                          return FlLine(
                            strokeWidth: 0,
                          );
                        }, getDrawingHorizontalLine: (value) {
                          return FlLine(
                            strokeWidth: 0,
                          );
                        }),
                        lineBarsData: [
                          LineChartBarData(
                            spots: flSpotList,
                            dotData: FlDotData(
                              show: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              getChartData("1");
                            },
                            child: Text("1d")),
                        ElevatedButton(
                            onPressed: () {
                              getChartData("15");
                            },
                            child: Text("15d")),
                        ElevatedButton(
                            onPressed: () {
                              getChartData("30");
                            },
                            child: Text("30d")),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class PriceAndTime {
  late int time;
  late double price;

  PriceAndTime({required this.time, required this.price});
}
