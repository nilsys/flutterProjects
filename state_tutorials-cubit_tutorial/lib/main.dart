import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:smtutorial/cubit/checkbox_cubit_screen.dart';

import 'cubit/cubit_observer.dart';
import 'cubit/drinks_cubit.dart';

void main() {
  // TODO Optional 4: Initialize the Observer into Cubit.observer
  Cubit.observer = MainCubitObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubit tutorial - Flutter Explained',
      theme: ThemeData.light().copyWith(primaryColor: Color(0xFFe13133)),
      home: CubitProvider(
          create: (context) => DrinksCubit(), child: CheckboxCubitScreen()),
    );
  }
}
