import 'package:flutter/material.dart';
import '../models/parking_data.dart';
import 'parkslot.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 0;
  List<ParkingData> get parkingHistory => ParkingSlotPage.parkingHistory;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Already on history page
        break;
      case 2:
        Navigator.pushNamed(context, '/mark');
        break;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3470A2)),
          onPressed: () => Navigator.pushNamed(context, '/home'),
        ),
        title: Text(
          'Riwayat Parkir',
          style: TextStyle(
            color: Color(0xFF3470A2),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFD358),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFFFD358),
        child: parkingHistory.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 80,
                      color: Color(0xFF3470A2),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Belum ada riwayat parkir',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3470A2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: parkingHistory.length,
                itemBuilder: (context, index) {
                  final parking = parkingHistory[index];
                  return _buildHistoryItem(
                    date: _formatDateTime(parking.time),
                    faculty: parking.faculty,
                    location: parking.location,
                    licensePlate: parking.licensePlate,
                    status: parking.status,
                    statusColor: _getStatusColor(parking.status),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Lokasi',
          ),
        ],
        currentIndex: 1, // History page is selected
        selectedItemColor: Color(0xFF3470A2),
        onTap: _onItemTapped,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'parkir selesai':
        return Colors.green;
      case 'parkir dibatalkan':
        return Colors.red;
      case 'parkir aktif':
        return Color(0xFF3470A2);
      default:
        return Colors.grey;
    }
  }

  Widget _buildHistoryItem({
    required String date,
    required String faculty,
    required String location,
    required String licensePlate,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3470A2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF3470A2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.local_parking,
                    size: 24,
                    color: Color(0xFF3470A2),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        faculty,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3470A2),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Lokasi: $location',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Plat Nomor: $licensePlate',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            status.toLowerCase() == 'parkir selesai'
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/parkslot');
                    },
                    child: Text(
                      'Parkir Ulang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3470A2),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}