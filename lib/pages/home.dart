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

  // Daftar lokasi parkir dan deskripsi
  final List<Map<String, String>> locations = [
    {'name': 'Politeknik', 'description': 'Politeknik Negeri Sriwijaya'},
    {'name': 'Fasilkom', 'description': 'Fakultas Ilmu Komputer'},
    {'name': 'FE', 'description': 'Fakultas Ekonomi'},
    {'name': 'FH', 'description': 'Fakultas Hukum'},
    {'name': 'FISIP', 'description': 'Fakultas Ilmu Sosiologi & Ilmu Politik'},
    {'name': 'GS', 'description': 'Graha Sriwijaya'},
    {'name': 'FT', 'description': 'Fakultas Teknik'},
    {'name': 'Universitas', 'description': 'Universitas Sriwijaya'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Tambahkan navigasi jika diperlukan
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
                    // Kirim nama lokasi ke halaman parkir
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
            'assets/map.png', // Pastikan file map ada di folder assets
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Tambahkan marker lokasi dari daftar
          for (int i = 0; i < locations.length; i++)
            _buildLocationMarker(
              context,
              0.2 + (i * 0.05), // Mengatur posisi x secara dinamis
              0.3 + (i * 0.05), // Mengatur posisi y secara dinamis
              locations[i]['name']!,
              locations[i]['description']!,
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
                backgroundColor: Colors.white.withOpacity(0.7), // Membantu agar teks terbaca
              ),
            ),
            Icon(Icons.location_on, color: Colors.blue, size: 30),
          ],
        ),
      ),
    );
  }
}
