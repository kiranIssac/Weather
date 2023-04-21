

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weathers/Model/CapitalModel.dart';
import 'package:weathers/Repository/ApiServices.dart';
import '../Model/WeatherModel.dart';

class CapitalViewModel extends ChangeNotifier{
  int Index=0;
  bool loading=true;
  bool loading1=true;
  WeatherModel weatherModel=WeatherModel(coord: Coord( lat:0,lon: 0), weather: [], base: '', main: Main(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0), visibility: 0, wind: Wind(speed: 0, deg: 0), clouds: Clouds(all: 0), dt: 0, sys: Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0), timezone: 0, id: 0, name: '', cod: 0);

  List<CapitalModel> capitalList=[];
 List<String> capital_List=[];
 ApiServices apiServices=ApiServices();
  CapitalViewModel(){
    getCapitalList();

  }
  setloading1(bool status){ // This status is used to know if the api call is completed for DetailWeather screen
    loading1=status;
    notifyListeners();
  }
  setloading(bool status){ //This status is used to know if the api call is completed for Capitals screen
    loading=status;
    notifyListeners();
  }
  getCapitalList() async{// Api for fetching country names and capitals is called and passed to a list
    setloading(true);
    capitalList= (await apiServices.FetchCapitals())!;
   for(int i=0;i< capitalList.length;i++){
     capital_List.add(capitalList[i].capital[0]);
   }
    setloading(false);
    notifyListeners();
  }
  FetchWeatherInfo(int index)async{ // This method is triggered when user slides to left. It fetches weather info of a specific capital
   setloading1(true);
    var  result= (await ApiServices().FetchWeather(capitalList[index].capital[0].toLowerCase()))!;
    Index++;
    SetWeatherInfo(result);

  }

  SetWeatherInfo(WeatherModel weather_model){
    weatherModel=weather_model;
    setloading1(false);
    notifyListeners();

  }
  passCapitalName(String name,BuildContext context)async{ // This method passes the capital which user selected and finds its position in the Capitals List
    setloading1(true);
    for(int i=0;i<capitalList.length;i++) {
      if (capitalList[i].capital[0].toLowerCase()==name.toLowerCase()){
        Index=i;
        FetchWeatherInfo(i);

      }
    }
  }
}