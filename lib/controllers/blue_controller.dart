import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:sos/utils/helper_functions.dart';

class BluetoothController extends GetxController {
  BluetoothConnection? _connection;
  Timer? _timer;
  String address = "";

  void connectToDevice(BluetoothDevice device) async {
    print(device.address);
    address = device.address;

    try {
      _connection = await BluetoothConnection.toAddress(device.address);
      print('Connected to the device');

      _connection!.input!.listen((Uint8List data) {
        String message = ascii.decode(data);
        print('only data: $message');

        double value;
        try {
          value = double.parse(message.toString());
        } catch (e) {
          print('Error parsing message: $e');
          return;
        }

        if (value > 10) {
          // Add your logic for values greater than 10
          sendMessageToAll();
          _connection!.close();
        } else if (value > 6) {
          _showDialogWithTimer();
          _connection!.close();

          // print("value getted than 6");
        }

        _connection!.output.add(data); // Sending data

        if (message.contains('!')) {
          _connection!.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print('Cannot connect, exception occurred');
    }
  }

  void _showDialogWithTimer() {
    _timer?.cancel(); // Cancel any existing timer
    Get.dialog(
      AlertDialog(
        title: Text('Alert'),
        content: CountdownWidget(),
        actions: [
          TextButton(
            onPressed: () {
              _timer?.cancel();
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );

    _timer = Timer(Duration(seconds: 30), () {
      sendMessageToAll();
      Get.back(); // Close the dialog if it's still open
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _connection?.dispose();
    super.onClose();
  }
}

class CountdownWidget extends StatefulWidget {
  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _countdownTimer;
  int _remainingTime = 30;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Time remaining: $_remainingTime seconds'),
      ],
    );
  }
}
