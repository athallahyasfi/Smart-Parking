import 'package:flutter/material.dart';
import 'marker.dart';

class MarkPage extends StatelessWidget {
  const MarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 52, 112, 162),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Lokasi Parkir', style: TextStyle(color: Colors.white)),
      ),

      backgroundColor: const Color.fromARGB(255, 255, 211, 88),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/icon.png',
                  height: 150,
                ),
              ),
          
              const SizedBox(height: 30),
          
              // title
              const Text(
                'Lokasi Parkir',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 52, 112, 162),
                ),
              ),
          
              const SizedBox(height: 24),
          
              //sub title
              const Text(
                'Silakan menuju ke lokasi parkir',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 52, 112, 162),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),
          
              // start now button
              GestureDetector(
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const MarkerPage(),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 52, 112, 162),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(25.0),
                  child: const Center(
                    child: Text(
                      'Buka Peta',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}