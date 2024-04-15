import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({super.key});

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String _data = 'https://example.com';
  int _selectedIndex = 1;
  bool _isLoading = false; 

  void _generateNewQRCode() {
    setState(() {
      _isLoading = true; 
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        _data = 'https://example.com?random=${Random().nextInt(1000)}';
        _isLoading = false; 
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _isLoading ? const CircularProgressIndicator() : buildQrImage(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _generateNewQRCode,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text(
              'Generate New QR Code',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code',),
       centerTitle: true, 
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
              },
        ),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildQrImage() {
    try {
      return QrImageView(
        data: _data,
        version: QrVersions.auto,
        size: 200.0,
        gapless: false,
    
        backgroundColor:  Colors.white,
      );
    } catch (e) {
       return Text("Failed to generate QR Code: $e");
    }
  }
}
