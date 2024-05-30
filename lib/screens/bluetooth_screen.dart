import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BlueToothScreen extends StatefulWidget {
  const BlueToothScreen({super.key});

  @override
  State<BlueToothScreen> createState() => _BlueToothScreenState();
}

class _BlueToothScreenState extends State<BlueToothScreen> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<List<BluetoothDevice>> scanDevices() async {
    List<BluetoothDevice> devices = [];

    try {
      // Start scanning for Bluetooth devices
      await flutterBlue.startScan(timeout: Duration(seconds: 4));

      // Listen for discovered devices
      flutterBlue.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (!devices.contains(result.device)) {
            devices.add(result.device);
          }
        }
      });

      // Wait for the scan to complete
      await Future.delayed(Duration(seconds: 4));

      // Stop scanning
      await flutterBlue.stopScan();
    } catch (e) {
      print('Error scanning for devices: $e');
    }

    return devices;
  }

  List<BluetoothDevice> _devices = [];
  Future<void> _scanDevices() async {
    List<BluetoothDevice> devices = await scanDevices();
    setState(() {
      _devices = devices;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _scanDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = _devices[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
          );
        },
      ),
    );
  }
}
