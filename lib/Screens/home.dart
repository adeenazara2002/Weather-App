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

  // Fetch the weather and update the state
  void getWeatherData(String cityName) async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await fetchWeather(cityName);
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
                          Image.asset('assets/images/smallCloud.png'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 150)),
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
                          Padding(padding: EdgeInsets.only(left: 120)),
                          Text(
                            weatherData!['weather'][0]['description'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 90)),
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
                SizedBox(height: 20),
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
                        child: Stack(
                          children: [
                            Column(
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
                                    Padding(
                                        padding: EdgeInsets.only(left: 160)),
                                    Text(
                                      'July, 21',
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
                                  // indent: 40, // Space from the left
                                  // endIndent: 40, // Space from the right
                                ),

                                // === scrollable container ===
                                Container(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align all to the start
                                      children: [
                                        // First Row
                                        Row(
                                          children: [
                                            SizedBox(width: 35),
                                            Text(
                                              '19 C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              '19 C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              '19 C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              '19 C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              '19 C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              '19 C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 40),
                                            Text(
                                              '19 C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // === SECOND ROW (Image Row) ===
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 30),
                                            Image.asset(
                                                'assets/images/moonCloud.png'),
                                            SizedBox(width: 30),
                                            Image.asset(
                                                'assets/images/moonCloud.png'),
                                            SizedBox(width: 30),
                                            Image.asset(
                                                'assets/images/moonCloud.png'),
                                            SizedBox(width: 30),
                                            Image.asset(
                                                'assets/images/moonCloud.png'),
                                            SizedBox(width: 40),
                                            Image.asset(
                                                'assets/images/moonCloud.png'),
                                            SizedBox(width: 30),
                                            Image.asset(
                                                'assets/images/moonCloud.png'),
                                            SizedBox(width: 30),
                                            Image.asset(
                                                'assets/images/moonCloud.png'),
                                          ],
                                        ),

                                        // === THIRD ROW (Time Row) ===
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 30),
                                            Text(
                                              '15:00',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Text(
                                              '15:00',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Text(
                                              '15:00',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Text(
                                              '15:00',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 35),
                                            Text(
                                              '15:00',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Text(
                                              '15:00',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(width: 25),
                                            Text(
                                              '15:00',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
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
