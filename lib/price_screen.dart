// ignore_for_file: library_private_types_in_public_api

import 'dart:io' show Platform;
import 'package:bitcoin_ticker/Network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './coin_data.dart';

const apiKey = 'B6ADE6E4-6F6C-4F42-9F11-4CDB5B78B368';

const List<String> currencyList = currenciesList;
const List<String> crypto = cryptoList;

String selectedCurrency = 'USD';
String selectedCrypto = 'BTC';
double? val;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> andrd() {
    return DropdownButton(
        value: selectedCurrency,
        items: [
          for (String i in currenciesList)
            DropdownMenuItem(
              value: i,
              child: Text(i),
            )
        ],
        onChanged: (value) {
          setState(() {
            getdata(value!);
            selectedCurrency = value;
          });
        });
//               // items: currencyList.map<DropdownMenuItem<String>>((String value) {
//               //   return DropdownMenuItem<String>(
//               //     value: value,
//               //     child: Text(value),
//               //   );
//               // }).toList(),//               onChanged: (value) {
//                 setState(() {
//                   selectedCurrency = value!;
//                 }),
//               },
//              )
//              )
  }

  CupertinoPicker appl() {
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (value) {
          getdata(currenciesList[value]);
        },
        children: [for (String i in currenciesList) Text(i)]);
  }

  getList() {}

  Future<dynamic> getdata(String cur) async {
    Network network = Network(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$cur?apikey=B6ADE6E4-6F6C-4F42-9F11-4CDB5B78B368');
    var data = await network.getData();
    double val1 = data['rate'];
    String inst = val1.toStringAsFixed(2);
    val = double.parse(inst);
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Center(
          child: Text('🤑 Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: crypto
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 $e = $val $selectedCurrency',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            //   child: Card(
            //     color: Colors.lightBlueAccent,
            //     elevation: 5.0,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(
            //           vertical: 15.0, horizontal: 28.0),
            //       child: Text(
            //         '1 $i = $val $selectedCurrency',
            //         textAlign: TextAlign.center,
            //         style: const TextStyle(
            //           fontSize: 20.0,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? appl() : andrd(),
          ),
        ],
      ),
    );
  }
}
