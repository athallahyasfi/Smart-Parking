import 'package:flutter/material.dart';
import '../models/parking_data.dart';

class ParkingSlotPage extends StatefulWidget {
  static List<ParkingData> parkingHistory = [];
  static Map<String, Set<String>> occupiedSlots = {}; // Track slots per lokasi

  @override
  _ParkingSlotPageState createState() => _ParkingSlotPageState();
}

class _ParkingSlotPageState extends State<ParkingSlotPage> {
  final TextEditingController _plateController = TextEditingController();
  String? _location; // Lokasi yang dipilih
  List<String> _leftSlots = []; // Slot parkir di kiri
  List<String> _rightSlots = []; // Slot parkir di kanan

  // Data slot parkir per lokasi
  final Map<String, Map<String, List<String>>> parkingSlots = {
    'Politeknik': {
      'left': List.generate(10, (index) => 'L-${index + 1}'),
      'right': List.generate(10, (index) => 'R-${index + 1}')
    },
    'Fasilkom': {
      'left': List.generate(12, (index) => 'L-${index + 1}'),
      'right': List.generate(12, (index) => 'R-${index + 1}')
    },
    'FE': {
      'left': List.generate(8, (index) => 'L-${index + 1}'),
      'right': List.generate(8, (index) => 'R-${index + 1}')
    },
    'FH': {
      'left': List.generate(12, (index) => 'L-${index + 1}'),
      'right': List.generate(12, (index) => 'R-${index + 1}')
    },
    'FT': {
      'left': List.generate(10, (index) => 'L-${index + 1}'),
      'right': List.generate(10, (index) => 'R-${index + 1}')
    },
    'FISIP': {
      'left': List.generate(10, (index) => 'L-${index + 1}'),
      'right': List.generate(10, (index) => 'R-${index + 1}')
    }
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Terima lokasi dari halaman Home
    _location = ModalRoute.of(context)?.settings.arguments as String?;
    if (_location != null && !ParkingSlotPage.occupiedSlots.containsKey(_location)) {
      ParkingSlotPage.occupiedSlots[_location!] = {}; // Inisialisasi lokasi
    }
    setState(() {
      _leftSlots = parkingSlots[_location]?['left'] ?? [];
      _rightSlots = parkingSlots[_location]?['right'] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slot Parkir ($_location)'),
        backgroundColor: Color(0xFFFFD358),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF3470A2)),
          onPressed: () => Navigator.pop(context),
        ),
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
                    // Kolom kiri
                    Expanded(child: _buildParkingColumn(context, _leftSlots, isLeft: true)),
                    SizedBox(width: 16), // Jalur kosong di tengah
                    Expanded(child: _buildParkingColumn(context, _rightSlots, isLeft: false)),
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
    );
  }

  Widget _buildParkingColumn(BuildContext context, List<String> slots, {required bool isLeft}) {
    return Column(
      children: List.generate(slots.length, (index) {
        final slot = slots[index];
        final isOccupied = ParkingSlotPage.occupiedSlots[_location]?.contains(slot) ?? false;

        return GestureDetector(
          onTap: () {
            if (!isOccupied) {
              _showLicensePlateDialog(slot);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isOccupied ? Color(0xFF87CEFA) : Colors.yellow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                slot,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _showLicensePlateDialog(String slot) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Masukkan Plat Nomor'),
          content: TextField(
            controller: _plateController,
            decoration: InputDecoration(
              labelText: 'Plat Nomor',
              hintText: 'Contoh: B 1234 ABC',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _confirmParking(slot);
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  void _confirmParking(String slot) {
    if (_plateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Plat nomor harus diisi!')),
      );
      return;
    }

    setState(() {
      ParkingSlotPage.occupiedSlots[_location]?.add(slot); // Tandai slot sebagai occupied
      ParkingSlotPage.parkingHistory.add(
        ParkingData(
          licensePlate: _plateController.text,
          location: '$_location - $slot',
          time: DateTime.now(),
          faculty: '', // Kosongkan karena tidak ada input fakultas di sini
        ),
      );
    });

    _plateController.clear();
    Navigator.of(context).pop();
    _showParkingSuccessDialog();
  }

  void _showParkingSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 16),
              Text(
                'Parkir berhasil!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
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
