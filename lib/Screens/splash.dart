import 'package:flutter/material.dart';
import 'package:weatherforecast/Screens/home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(28, 37, 70, 1.0),
              Color.fromRGBO(54, 54, 118, 1.0),
              Color.fromRGBO(72, 60, 146, 1.0),
              Color.fromRGBO(91, 65, 164, 1.0),
              Color.fromRGBO(107, 75, 172, 1.0),
              Color.fromRGBO(122, 81, 171, 1.0),
              Color.fromRGBO(128, 84, 173, 1.0),
              Color.fromRGBO(137, 76, 172, 1.0),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 180,
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 25)),
                Image.asset('assets/images/cloud.png'),
              ],
            ),
            // === TEXT ROW ===
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 80)),
                    Text(
                      'Weather',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // === TEXT 2 ROW ===
                Padding(
                  padding: EdgeInsets.only(
                      top: 50, left: 80), // Adjust this for desired space
                  child: Text(
                    'Forecast',
                    style: TextStyle(
                      color: Color.fromRGBO(221, 177, 48, 1.0),
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            // === BUTTON ===

            SizedBox(
              height: 30,
            ),

            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(221, 177, 48, 1.0),
                      foregroundColor: Color.fromRGBO(72, 60, 146, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 18.0),
                      child: Text(
                        'Get Start',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
