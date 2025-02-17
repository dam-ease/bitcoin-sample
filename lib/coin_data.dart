//2. Import the required packages.
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '3C5B0AB6-F8DF-44E4-A8D3-AAA07C945F4F';

class CoinData {
  //TODO 3: Update getCoinData to take the selectedCurrency as an input.
  Future getCoinData(String selectedCurrency) async {
    //TODO 4: Update the URL to use the selectedCurrency input.
    String requestURL = '$coinAPIURL/BTC?invert=false&apikey=$apiKey';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      print(decodedData);
      double rate = 0.00;

      for (int i = 0; i < decodedData["rates"].length; i++) {
        decodedData["rates"][i].forEach((key, value) {
          final assetIds = value as List;
          print('assetIds: $assetIds');
          final selectedAssetId =
              assetIds.where((element) => element == selectedCurrency).toList();
          print('selectedAssetId: $selectedAssetId');

          decodedData["rates"][i][key] = selectedAssetId.map((b) => print(b));
        });
      }
      print(rate);
      double lastPrice = decodedData['rate'];

      return lastPrice.toStringAsFixed(0);
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
