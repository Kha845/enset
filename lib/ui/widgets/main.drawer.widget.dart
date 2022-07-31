import 'package:flutter/material.dart';
import 'main.drawer.header.dart';
import 'main.drawer.item.widget.dart';
class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> menus = [
      {
        'title': 'Home', 'leadingIcon': Icons.home,
        'trainlingIcon': Icons.arrow_forward, 'route': '/home'
      },
      {
        'title': 'Counter Stful',
        'leadingIcon': Icons.event,
        'trainlingIcon': Icons.arrow_forward,
        'route': '/counter1'
      },
      {
        'title': 'Counter Bloc', 'leadingIcon':Icons.timer,
        'trainlingIcon':Icons.arrow_forward,
        'route': '/counter2'
      },
      {
        'title': 'Git users', 'leadingIcon': Icons.person,
        'trainlingIcon':Icons.arrow_forward,
        'route': '/users'
      },
      {'title': 'OCR', 'leadingIcon': Icons.qr_code, 'trainlingIcon':Icons.arrow_forward,'route': '/ocr'},
      {'title': 'QR Code', 'leadingIcon': Icons.qr_code,'trainlingIcon':Icons.arrow_forward, 'route': '/qrCode'},
    ];
    return Drawer(
      child: Column(
        children: [
          const MainDrawerHeader(),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context,index){
                  return DrawerItemWidget(
                    title: menus[index]['title'],
                    leadingIcon: menus[index]['leadingIcon'],
                    trainlingIcon: menus[index]['trainlingIcon'],
                    onAction: (){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, menus[index]['route']);
                    },

                  );
                },
                separatorBuilder: (context,index){
                  return const Divider(height: 6,);
                },
                itemCount: menus.length)
            ),
    ]
      ),
    );
  }
}
