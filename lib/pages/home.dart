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

  final List<Map<String, dynamic>> locations = [
    {'name': 'Politeknik', 'description': 'Politeknik Negeri Sriwijaya', 'left': 0.22, 'top': 0.35},
    {'name': 'Fasilkom', 'description': 'Fakultas Ilmu Komputer', 'left': 0.18, 'top': 0.45},
    {'name': 'FE', 'description': 'Fakultas Ekonomi', 'left': 0.32, 'top': 0.45},
    {'name': 'FH', 'description': 'Fakultas Hukum', 'left': 0.45, 'top': 0.4},
    {'name': 'FISIP', 'description': 'Fakultas Ilmu Sosiologi & Ilmu Politik', 'left': 0.35, 'top': 0.55},
    {'name': 'GS', 'description': 'Graha Sriwijaya', 'left': 0.55, 'top': 0.5},
    {'name': 'FT', 'description': 'Fakultas Teknik', 'left': 0.75, 'top': 0.45},
    {'name': 'Universitas', 'description': 'Universitas Sriwijaya', 'left': 0.45, 'top': 0.7},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showLocationPopup(BuildContext context, String locationName) {
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
                child: Text(
                  locationName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      '/parkslot',
                      arguments: locationName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3470A2),
                    minimumSize: Size(double.infinity, 50),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Pilih Tempat'),
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
            'assets/map.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          for (var location in locations)
            _buildLocationMarker(
              context,
              location['left'],
              location['top'],
              location['name'],
              location['description'],
            ),
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

  Widget _buildLocationMarker(
      BuildContext context, double left, double top, String name, String description) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top,
      child: GestureDetector(
        onTap: () => _showLocationPopup(context, name),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.white.withOpacity(0.7),
              ),
            ),
            Icon(Icons.location_on, color: Colors.blue, size: 30),
          ],
        ),
      ),
    );
  }
}
