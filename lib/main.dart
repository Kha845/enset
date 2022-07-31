import 'package:enset/bloc/counter.bloc.dart';
import 'package:enset/bloc/users.bloc.dart';
import 'package:enset/ui/pages/counter.bloc.page.dart';
import 'package:enset/ui/pages/counter.stateful.page.dart';
import 'package:enset/ui/pages/home.page.dart';
import 'package:enset/ui/pages/root.view.dart';
import 'package:enset/ui/pages/users.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/theme.bloc.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>CounterBloc()),
          BlocProvider(create: (context)=>ThemeBloc()),
          BlocProvider(create: (context)=>UsersBloc()),
        ],
        child: const RootView()
    );
  }
}
