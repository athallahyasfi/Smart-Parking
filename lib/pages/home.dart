import 'package:flutter/material.dart';
import 'parkslot.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? currentParkingLocation;

  final List<Map<String, dynamic>> locations = [
    {'name': 'Politeknik', 'shortName': 'Politeknik', 'description': 'Politeknik Negeri Sriwijaya', 'left': 0.22, 'top': 0.35},
    {'name': 'Fasilkom', 'shortName': 'Fasilkom', 'description': 'Fakultas Ilmu Komputer', 'left': 0.18, 'top': 0.45},
    {'name': 'FE', 'shortName': 'FE', 'description': 'Fakultas Ekonomi', 'left': 0.32, 'top': 0.45},
    {'name': 'FH', 'shortName': 'FH', 'description': 'Fakultas Hukum', 'left': 0.45, 'top': 0.4},
    {'name': 'FISIP', 'shortName': 'FISIP', 'description': 'Fakultas Ilmu Sosial dan Politik', 'left': 0.35, 'top': 0.55},
    {'name': 'GS', 'shortName': 'GS', 'description': 'Graha Sriwijaya', 'left': 0.55, 'top': 0.5},
    {'name': 'FT', 'shortName': 'FT', 'description': 'Fakultas Teknik', 'left': 0.75, 'top': 0.45},
    {'name': 'Universitas', 'shortName': 'Universitas', 'description': 'Universitas Sriwijaya', 'left': 0.45, 'top': 0.7},
  ];

  void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });

  switch (index) {
    case 0:
      // Navigasi ke Home
      Navigator.pushReplacementNamed(context, '/home');
      break;
    case 1:
      // Navigasi ke Profile
      Navigator.pushReplacementNamed(context, '/profile');
      break;
    case 2:
      // Navigasi ke History
      Navigator.pushReplacementNamed(context, '/history');
      break;
  }
}
  

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar Parkir'),
          content: const Text('Apakah Anda yakin ingin keluar dari area parkir?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Keluar'),
              onPressed: () {
                setState(() {
                  currentParkingLocation = null;
                });
                ParkingSlotPage.clearParking();
                Navigator.pop(context);
              },
            ),
          ],
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
        backgroundColor: const Color(0xFFFFD358),
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Color(0xFF3470A2)),
          onPressed: () => Navigator.pushNamed(context, '/login'),
        ),
        actions: [
          if (currentParkingLocation != null)
            IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.red),
              onPressed: () => _showExitDialog(context),
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
              location['shortName'],
              location['description'],
              location['name'] == currentParkingLocation,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildLocationMarker(
    BuildContext context,
    double left,
    double top,
    String name,
    String shortName,
    String description,
    bool isParked,
  ) {
    return Positioned(
      left: MediaQuery.of(context).size.width * left,
      top: MediaQuery.of(context).size.height * top - 30, // Tempatkan teks di atas marker
      child: GestureDetector(
        onTap: () {
          if (currentParkingLocation == null) {
            Navigator.pushNamed(
              context,
              '/parkslot',
              arguments: name,
            ).then((_) {
              setState(() {
                currentParkingLocation = name;
              });
            });
          }
        },
        child: Column(
          children: [
            Text(
              shortName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                backgroundColor: Colors.white70,
              ),
            ),
            Icon(
              Icons.location_on,
              color: isParked ? Colors.green : Colors.blue,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
