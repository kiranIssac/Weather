import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathers/ViewModel/Capital_viewModel.dart';

import '../Model/WeatherModel.dart';

class DetailsWeather extends StatefulWidget {
  @override
  _DetailsWeatherState createState() => _DetailsWeatherState();
}

class _DetailsWeatherState extends State<DetailsWeather>
    with SingleTickerProviderStateMixin {
  WeatherModel weatherModel = WeatherModel(
      coord: Coord(lat: 0, lon: 0),
      weather: [],
      base: '',
      main: Main(
          temp: 0,
          feelsLike: 0,
          tempMin: 0,
          tempMax: 0,
          pressure: 0,
          humidity: 0),
      visibility: 0,
      wind: Wind(speed: 0, deg: 0),
      clouds: Clouds(all: 0),
      dt: 0,
      sys: Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0),
      timezone: 0,
      id: 0,
      name: 'kk',
      cod: 0);

  late AnimationController _animationController;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(-1.0, 0.0))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<CapitalViewModel>(builder: (context, provider, child) {
      int Index = provider.Index;
      print(Index.toString() + 'hhhh');
      weatherModel = provider.weatherModel;
      return provider.loading1 == false
          ? GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) async {
               if (details.velocity.pixelsPerSecond.dx < 0) {// To detect when the user swipes to left
                  // user swiped left, animate page slide
                  await _animationController.forward();
                  Provider.of<CapitalViewModel>(context, listen: false)// After user swipes next capital weather info is fetched using CapitalModel change notifier
                      .FetchWeatherInfo(Index);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          DetailsWeather(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
              },
              child: Scaffold(
                backgroundColor: Color(0xff14306F),
                appBar: AppBar(
                  backgroundColor: Color(0xff14306F),
                  title: Text("Slider Page"),
                ),
                body: SlideTransition(
                  position: _animation,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenWidth * .25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("Images/Vector2.png"),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(weatherModel.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                      Image.asset("Images/image 4.png", height: 150),
                      Text(weatherModel.weather[0].main,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: screenWidth * .05,
                      ),
                      Text(weatherModel.weather[0].description.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: screenWidth * .1,
                      ),
                      Text(weatherModel.main.temp.toString() + '°F',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: screenWidth * .1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("Images/Vector3.png"),
                          SizedBox(
                            width: 10,
                          ),
                          Text(weatherModel.wind.speed.toString() + 'mp/h',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Color(0xff14306F),
              appBar: AppBar(
                backgroundColor: Color(0xff14306F),
                title: Text("Slide Page"),
              ),
              body: Center(child: CircularProgressIndicator()));
    });
  }
}
