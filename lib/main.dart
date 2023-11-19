import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sm_bar_master_frontend/ui/memory/memory_page.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        // etc.
      };
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: const MemoryPage(),
    );
  }
}



// TODO - remote_datasource 에서 create함수 만들기
// TODO - 사용 -> localhost:3003/album로 post요청 
