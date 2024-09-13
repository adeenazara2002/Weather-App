import 'package:flutter/material.dart';
import 'package:weatherforecast/Screens/forecast.dart';
import 'package:weatherforecast/Services/weather_service.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = 'Karachi'; // Default city
  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getWeatherData(city); // Fetch weather for Karachi on app start
  }

  // Function to get the weather icon based on the icon code from the API
  String getWeatherIcon(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}'; // Format to your preference
  }

  List<Widget> buildForecast() {
    if (weatherData == null || weatherData!['daily'] == null) {
      return [Text('No forecast available')]; // Handle null case
    }

    return List.generate(7, (index) {
      final day = weatherData!['daily'][index]; // Access each day's forecast
      final temp = day['temp']['day'];
      final time = DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000);

      return Column(
        children: [
          Text('${temp.toStringAsFixed(1)}°C',
              style: TextStyle(color: Colors.white)),
          Image.network(getWeatherIcon(day['weather'][0]['icon'])),
          Text('${time.hour}:00', style: TextStyle(color: Colors.white)),
        ],
      );
    });
  }

  // Fetch the weather and update the state
  void getWeatherData(String cityName) async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await fetchWeather(cityName, forecast: true);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error (show a message, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Forecast(),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(28, 37, 70, 1.0),
                  Color.fromRGBO(40, 46, 93, 1.0),
                  Color.fromRGBO(57, 56, 124, 1.0),
                  Color.fromRGBO(63, 56, 134, 1.0),
                  Color.fromRGBO(74, 60, 148, 1.0),
                  Color.fromRGBO(67, 59, 141, 1.0),
                  Color.fromRGBO(84, 63, 158, 1.0),
                  Color.fromRGBO(108, 74, 171, 1.0),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
                // Search bar
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Container(
                        height: 55,
                        width: 310,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: TextField(
                          onSubmitted: (value) {
                            getWeatherData(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 25,
                            ),
                            hintText: 'Search city or country',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Weather data display
                if (isLoading)
                  CircularProgressIndicator()
                else if (weatherData != null)
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 120)),
                          Image.network(getWeatherIcon(
                              weatherData!['weather'][0]['icon'])),
                        ],
                      ),
                      // SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 130)),
                          Text(
                            '${weatherData!['main']['temp']}°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              weatherData!['weather'][0]['description'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign:
                                  TextAlign.center, // Always center the text
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 50)),
                          Text(
                            'Max: ${weatherData!['main']['temp_max']}°C ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text(
                            'Min: ${weatherData!['main']['temp_min']}°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 30),
                // Additional UI elements...
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 60)),
                    Image.asset('assets/images/house.png'),
                  ],
                ),
                // ==== CONTAINER ====
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 0.3, 0.5, 0.7, 1.0],
                            colors: [
                              Color.fromRGBO(
                                  135, 75, 171, 1.0), // Lightest shade
                              Color.fromRGBO(121, 80, 172, 1.0),
                              Color.fromRGBO(108, 74, 171, 1.0), // Middle shade
                              Color.fromRGBO(84, 63, 158, 1.0),
                              Color.fromRGBO(67, 59, 141, 1.0), // Darkest shade
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Color.fromRGBO(108, 74, 171, 1.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 40)),
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(left: 140)),
                                Text(
                                  getCurrentDate(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            // === scrollable container ===
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: buildForecast(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
