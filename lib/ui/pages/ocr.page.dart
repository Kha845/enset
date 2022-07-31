import 'package:flutter/material.dart';
class OcrPage extends StatelessWidget {
  const OcrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OCR"),
      ),
      body: const Center(
        child: Text("OCR"),
      ),
    );
  }
}
