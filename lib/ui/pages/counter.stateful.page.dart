import 'package:enset/ui/widgets/main.drawer.widget.dart';
import 'package:flutter/material.dart';

import '../themes/themes.dart';
class CounterStateFulPage extends StatefulWidget {
  const CounterStateFulPage({Key? key}) : super(key: key);
  @override
  State<CounterStateFulPage> createState() => _CounterStateFulState();
}

class _CounterStateFulState extends State<CounterStateFulPage> {
  int counter=0;
  String errorMessage="";
  @override
  Widget build(BuildContext context) {
    //le seul moyen de permettre un widget d'actualiser le contenu
    //c'est de reexecuter la methode build
    //la méthode qui regener l'etat du widget
    print("Building widgets tree");
    return Scaffold(
     appBar: AppBar(title: const Text("counter Stateful")),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter Value => $counter",
              style: Theme.of(context).textTheme.headline4,),
            (errorMessage!='')?
                Text("$errorMessage",
                  style: CustomThemes.errorTextStyle)
                    : const Text("")
          ]
        ),
    ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "dec",
              onPressed: (){
              setState(() {
                if(counter>0){
                  --counter;
                  errorMessage="";
                }else {
                  errorMessage="Counter value can not be lee than 0";
                }
                });
              },
          child: const Icon(Icons.remove)
          ),
          const SizedBox(width: 8,),
          FloatingActionButton(
            heroTag: "inc",
              onPressed: (){
                setState(() {
                  if(counter<10) {
                    errorMessage="";
                    ++counter;
                  }else{
                    errorMessage="Counter value can not be less than 0";
                  }
                });
              },
              child: const Icon(Icons.add))
        ],
      ),
    );
  }
}

