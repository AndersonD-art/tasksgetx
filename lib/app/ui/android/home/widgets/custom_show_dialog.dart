import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarefas/app/controller/home_controller.dart';
import 'package:tarefas/app/data/models/home_model.dart';

class CustomShowDialog extends StatelessWidget {
  final TextEditingController _editingController = TextEditingController();

  final HomeModel task;

  CustomShowDialog({Key? key, required this.task}) : super(key: key);

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    _editingController.text = task.name;
    return Container(
      child: AlertDialog(
        title: Text(
          "Editar Tarefa",
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _editingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Tarefa",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancelar",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              task.name = _editingController.text;
              await _homeController.updateTask(edit: task);
              Navigator.pop(context);
            },
            child: Text(
              "Atualizar",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
