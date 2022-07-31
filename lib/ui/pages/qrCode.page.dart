import 'package:flutter/material.dart';
class QrCodePage extends StatelessWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr code"),
      ),
      body: const Center(
        child: Text("QR code"),
      ),
    );
  }
}
