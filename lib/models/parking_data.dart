class ParkingData {
  final String licensePlate;
  final String location;
  final DateTime time;
  final String faculty;
  final String status;

  ParkingData({
    required this.licensePlate,
    required this.location,
    required this.time,
    required this.faculty,
    this.status = 'Parkir aktif',
  });
}