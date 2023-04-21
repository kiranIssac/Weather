import '../Model/CapitalModel.dart';
import 'package:http/http.dart' as http;

import '../Model/WeatherModel.dart';

class ApiServices{
  String baseUrl="https://api.openweathermap.org/data/2.5/weather?q=";

 Future<List<CapitalModel>?> FetchCapitals()async{// Api call for fetching List of countries and capitals
    print('2nd call');
    var response = await http.get(Uri.parse("https://restcountries.com/v3.1/independent?status=true&fields=capital,name"));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return capitalModelFromJson(response.body);

    }
  }
  Future<WeatherModel?> FetchWeather(String capitalName)async{ //Api for fetching weather info based on capital of a coountry
   String url=baseUrl+capitalName+"&appid=2a63928ffc5d230c155fbafe5fbf779f";
   print(url);
    var response = await http.get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return weatherModelFromJson(response.body);

    }
  }
}