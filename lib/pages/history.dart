import 'package:flutter/material.dart';
import '../models/parking_data.dart';
import 'parkslot.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 0;
  List<ParkingData> get parkingHistory => ParkingSlotPage.parkingHistory;



  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3470A2)),
          onPressed: () => Navigator.pushNamed(context, '/home'),
        ),
        title: const Text(
          'Riwayat Parkir',
          style: TextStyle(
            color: Color(0xFF3470A2),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFD358),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFFFFD358),
        child: parkingHistory.isEmpty
            ? const Center(
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
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'parkir selesai':
        return Colors.green;
      case 'parkir dibatalkan':
        return Colors.red;
      case 'parkir aktif':
        return const Color(0xFF3470A2);
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3470A2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3470A2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_parking,
                    size: 24,
                    color: Color(0xFF3470A2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        faculty,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3470A2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lokasi: $location',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
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
            const SizedBox(height: 12),
            status.toLowerCase() == 'parkir selesai'
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/parkslot');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3470A2),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Parkir Ulang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}