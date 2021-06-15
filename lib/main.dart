import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tarefas/app/routes/app_page_routes.dart';
import 'package:tarefas/app/routes/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarefas',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Colors.orange[900],
      ),
      getPages: Pages.routes,
      initialRoute: AppRoutes.INITIAL,
    );
  }
}
