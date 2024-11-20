import 'package:flutter/material.dart';
import '../models/parking_data.dart';

class ParkingSlotPage extends StatefulWidget {
  static List<ParkingData> parkingHistory = [];

  @override
  _ParkingSlotPageState createState() => _ParkingSlotPageState();
}

class _ParkingSlotPageState extends State<ParkingSlotPage> {
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  
  // Track occupied slots for both columns
  Set<String> occupiedSlots = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3470A2)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 200,
            height: 50,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.location_on, color: Color(0xFF3470A2)),
              onPressed: () {
                Navigator.pushNamed(context, '/mark');
              },
            ),
          ),
        ],
        backgroundColor: Color(0xFFFFD358),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFFFD358),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: _buildParkingColumn(context, true)),
                    SizedBox(width: 16),
                    Expanded(child: _buildParkingColumn(context, false)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(Colors.yellow, 'Free Slot'),
                  _buildLegendItem(Color(0xFF87CEFA), 'Taken Slot'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Lokasi'),
        ],
        currentIndex: 0,
        selectedItemColor: Color(0xFF3470A2),
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/history');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/mark');
          } else {
            Navigator.pushNamed(context, '/home');
          }
        },
      ),
    );
  }

  Widget _buildParkingColumn(BuildContext context, bool isLeftColumn) {
    return Column(
      children: List.generate(10, (index) {
        String slotId = '${isLeftColumn ? "L" : "R"}-$index';
        bool isOccupied = occupiedSlots.contains(slotId);
        
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (!isOccupied) {
                _showLicensePlateDialog(context, isLeftColumn, index);
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isOccupied ? Color(0xFF87CEFA) : Colors.yellow,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              width: 100,
              height: 50,
              child: isOccupied
                  ? Icon(Icons.directions_car, color: Colors.black)
                  : SizedBox(),
            ),
          ),
        );
      }),
    );
  }

  void _showLicensePlateDialog(BuildContext context, bool isLeftColumn, int slotIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Masukkan Data Parkir'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _plateController,
                decoration: InputDecoration(
                  labelText: 'Plat Nomor',
                  hintText: 'Contoh: B 1234 ABC',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _facultyController,
                decoration: InputDecoration(
                  labelText: 'Fakultas',
                  hintText: 'Contoh: Fakultas Ilmu Komputer',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
                _plateController.clear();
                _facultyController.clear();
              },
            ),
            TextButton(
              child: Text('Konfirmasi'),
              onPressed: () {
                _confirmParking(context, isLeftColumn, slotIndex);
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmParking(BuildContext context, bool isLeftColumn, int slotIndex) {
    if (_plateController.text.isEmpty || _facultyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    String slotId = '${isLeftColumn ? "L" : "R"}-$slotIndex';
    String location = '${isLeftColumn ? "Kiri" : "Kanan"} - Slot ${slotIndex + 1}';
    
    setState(() {
      occupiedSlots.add(slotId); // Mark the slot as occupied
    });

    // Add to parking history
    ParkingSlotPage.parkingHistory.add(
      ParkingData(
        licensePlate: _plateController.text,
        location: location,
        time: DateTime.now(),
        faculty: _facultyController.text,
      ),
    );

    Navigator.of(context).pop();
    _plateController.clear();
    _facultyController.clear();
    
    _showParkingSuccessDialog(context);
  }

  void _showParkingSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Color(0xFF3470A2), size: 50),
                SizedBox(height: 16),
                Text(
                  'Anda berhasil parkir.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
