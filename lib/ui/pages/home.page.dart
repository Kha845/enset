import 'package:flutter/material.dart';

import '../widgets/main.drawer.widget.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: const Text("Home page")),
      body: const Center(
        child: Text("Home Page"),
      )
    );
  }
}
