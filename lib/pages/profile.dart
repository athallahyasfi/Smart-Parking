import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: const Color(0xFFFFD358),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3470A2)),
          onPressed: () => Navigator.pushNamed(context, '/home'),
        ),
      ),
      
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFD358),
              Color(0xFFEFEFEF),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF3470A2),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoRow(Icons.person, 'Nama:', 'John Doe'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.directions_car, 'Tipe Kendaraan:', 'Mobil'),
            
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3470A2), size: 30),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}