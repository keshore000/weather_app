import 'package:flutter/material.dart';
import 'wservice.dart';

class weatherprovider with ChangeNotifier{
  weatherservice ws=new weatherservice();
  Map<String,dynamic>?wdata;
  bool isLoading=true;

  Future<void> getWeather(double latitude,double longitude)async{
    print('Fetching weather for: $latitude, $longitude');
    isLoading=true;
    notifyListeners();
 try{ wdata = await ws.fetchWeather(latitude,longitude);}
 catch(e){print(e);wdata=null;}
  print(wdata);
  isLoading=false;
  notifyListeners();
  }
}