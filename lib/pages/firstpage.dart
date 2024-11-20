import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          // Applying the gradient background
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFD358), // Yellow shade (FFD358)
                Color(0xFFEFEFEF), // Light grey shade (EFEFEF)
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Smart Parking logo (replace text with logo image)
                Image.asset(
                  'assets/logo.png', // Path to your logo image
                  width: 500, // Adjust size as needed
                  height: 50,
                ),
                SizedBox(height: 20), // Spacing between logo and button

                // "Next" button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1A73E8), // Use backgroundColor instead of primary
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Text color
                    ),
                  ),               
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}