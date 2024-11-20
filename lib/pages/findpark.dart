import 'package:flutter/material.dart';

class FindParkingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFD358),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3470A2)), // Mengubah warna ikon back
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/logo.png', // Pastikan logo sudah dalam ukuran proporsional
          width: 200,
          height: 50,
        ),
        centerTitle: true, // Logo akan berada di tengah
        backgroundColor: Color(0xFFFFD358),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Temukan Tempat\nParkir',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3470A2), // Mengubah warna teks
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(
                    icon: Icons.person,
                    label: 'Dosen',
                    onTap: () {
                      Navigator.pushNamed(context, '/parkslot');
                    },
                  ),
                  _buildOption(
                    icon: Icons.school,
                    label: 'Mahasiswa',
                    onTap: () {
                      Navigator.pushNamed(context, '/parkslot');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue, // Warna Bottom Navigation tidak diubah
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Color(0xFF3470A2)), // Mengubah warna ikon
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3470A2), // Mengubah warna teks
              ),
            ),
          ],
        ),
      ),
    );
  }
}
