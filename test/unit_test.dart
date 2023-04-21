import 'package:flutter_test/flutter_test.dart';
import 'package:weathers/Repository/ApiServices.dart';

void main(){
  group("Api calls", () {
    test('fetch api', ()async {
      bool done= false;
      var fetch =await ApiServices().FetchCapitals();
      if(fetch !=null){
        done=true;
      }
      expect(done, true);
    });
    test('fetch api', ()async {
      bool done= false;
      var fetch1 =await ApiServices().FetchWeather('London');
      if(fetch1 !=null){
        done=true;
      }
      expect(done, true);
    });
  });


}