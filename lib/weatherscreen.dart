import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wprovider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController latcon = TextEditingController();
  TextEditingController loncon = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch weather data after the initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<weatherprovider>(context, listen: false).getWeather(37.7749, -122.4194);
    });
  }

  @override
  Widget build(BuildContext context) {
    final wp = Provider.of<weatherprovider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purpleAccent, Colors.pink], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,  // Centers both image and text
                children: [
                  Image.asset(
                    'assets/wede.png',  // Path to your image asset
                    height: 50,  // Adjust the height of the image as needed
                  ),
                  SizedBox(width: 10),  // Adds spacing between the image and the title
                  Text(
                    'Weather App',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),

            Expanded(
              child: Consumer<weatherprovider>(
                builder: (context, wp, child) {
                  return wp.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : wp.wdata != null
                      ? Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: latcon,
                          decoration: InputDecoration(
                            labelText: 'Latitude',
                            labelStyle: TextStyle(fontSize: 16, color: Colors.white60),
                            prefixIcon: Icon(Icons.location_on, color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.white!, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white!, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: loncon,
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            labelStyle: TextStyle(fontSize: 16, color: Colors.white60),
                            prefixIcon: Icon(Icons.location_on, color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.white!, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white!, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black),
                          onPressed: () async {
                            double lati = double.parse(latcon.text);
                            double longi = double.parse(loncon.text);
                            Provider.of<weatherprovider>(context, listen: false)
                                .getWeather(lati, longi);
                          },
                          child: Text('Get weather'),
                        ),
                        SizedBox(height: 100),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.device_thermostat, color: Colors.white, size: 30),
                                SizedBox(width: 10),
                                Text(
                                  'Temperature: ',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                Text(
                                  '${wp.wdata!["hourly"]["temperature_2m"][0]}°C',
                                  style: TextStyle(fontSize: 20, color: Colors.white70),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            Row(
                              children: [
                                Icon(Icons.water_drop_rounded, color: Colors.white, size: 30),
                                SizedBox(width: 10),
                                Text(
                                  'Humidity: ',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                Text(
                                  '${wp.wdata!["hourly"]["relative_humidity_2m"][0]}%',
                                  style: TextStyle(fontSize: 20, color: Colors.white70),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.waves, color: Colors.white, size: 30),
                                SizedBox(width: 10),
                                Text(
                                  'Wind Speed: ',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                Text(
                                  '${wp.wdata!["hourly"]["wind_speed_10m"][0]} km/h',
                                  style: TextStyle(fontSize: 20, color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        )

                      ],
                    ),
                  )
                      : Center(
                    child: Text('Problem occurred', style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
