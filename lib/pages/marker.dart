import 'package:flutter/material.dart';

class MarkerPage extends StatefulWidget {
  const MarkerPage({super.key});

  @override
  State<MarkerPage> createState() => _MarkerPageState();
}

class _MarkerPageState extends State<MarkerPage> {
  final TransformationController _controller = TransformationController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.value = Matrix4.identity()
        ..translate(-300.0, -200.0) // Sesuaikan nilai ini untuk menggeser fokus
        ..scale(2.0); // Sesuaikan nilai ini untuk level zoom yang diinginkan
    });
  }

  void _resetPosition() {
    _controller.value = Matrix4.identity()
      ..translate(-300.0, -200.0)
      ..scale(2.0);
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin melanjutkan?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () => Navigator.of(context).pop(),
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
        backgroundColor: const Color.fromARGB(255, 52, 112, 162),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Lokasi Parkir', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.center_focus_strong, color: Colors.white),
            onPressed: _resetPosition,
          ),
        ],
      ),
      body: Stack(
        children: [
          InteractiveViewer(
            transformationController: _controller,
            panEnabled: true,
            scaleEnabled: true,
            constrained: true,
            minScale: 0.5,
            maxScale: 4.0,
            child: Image.asset(
              'assets/mapexpand.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 2,
              height: MediaQuery.of(context).size.height * 2,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: const Color.fromARGB(255, 255, 211, 88),
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Fakultas Ilmu Komputer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 52, 112, 162),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Universitas Sriwijaya',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 52, 112, 162),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _showConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 52, 112, 162),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Konfirmasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}