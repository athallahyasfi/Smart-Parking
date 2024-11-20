import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on index if needed
  }

  void _showLocationPopup(BuildContext context, String locationName, String description) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locationName,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(description),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('Pilih Tempat'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/findpark');
                  },
                  style: ElevatedButton.styleFrom(
                     backgroundColor:Color(0xFF3470A2), // ganti 'primary' dengan 'backgroundColor'
                     minimumSize: Size(double.infinity, 50),
                     foregroundColor: Colors.white
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 200,
            height: 50,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFD358),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3470A2)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Color(0xFF3470A2)),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/map.png', // Make sure you have this asset
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Add all location markers
          _buildLocationMarker(context, 0.22, 0.35, 'Politeknik', 'Politeknik Negeri Sriwijaya'),
          _buildLocationMarker(context, 0.18, 0.45, 'Fasilkom', 'Fakultas Ilmu Komputer'),
          _buildLocationMarker(context, 0.32, 0.45, 'FE', 'Fakultas Ekonomi'),
          _buildLocationMarker(context, 0.45, 0.4, 'Location 1', 'Description for Location 1'),
          _buildLocationMarker(context, 0.35, 0.55, 'Location 2', 'Description for Location 2'),
          _buildLocationMarker(context, 0.55, 0.5, 'Location 3', 'Description for Location 3'),
          _buildLocationMarker(context, 0.75, 0.45, 'Location 4', 'Description for Location 4'),
          _buildLocationMarker(context, 0.45, 0.7, 'Universitas', 'Universitas Sriwijaya'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildLocationMarker(BuildContext context, double left, double top, String name, String description) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: GestureDetector(
        onTap: () => _showLocationPopup(context, name, description),
        child: Icon(Icons.location_on, color: Colors.blue, size: 30),
      ),
    );
  }
}
