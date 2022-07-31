import 'package:enset/ui/pages/git.users.page.dart';
import 'package:enset/ui/pages/ocr.page.dart';
import 'package:enset/ui/pages/qrCode.page.dart';
import 'package:enset/ui/pages/users.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme.bloc.dart';
import 'counter.bloc.page.dart';
import 'counter.stateful.page.dart';
import 'home.page.dart';
class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return   BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context,state){
          return MaterialApp(
            theme:state.themeData,
            routes: {
              "/": (context)=>const HomePage(),
              "/counter1": (context)=> const CounterStateFulPage(),
              "/counter2": (context)=> const CounterBlocPage(),
              "/users": (context)=> const GitUsersPage(),
              "/ocr":(context)=> const OcrPage(),
              "/qrCode":(context)=>const QrCodePage()
            },
              initialRoute: "/",
          );
        }
      );
  }
}
