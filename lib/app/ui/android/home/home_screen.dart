import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/app/controller/home_controller.dart';
import 'package:tarefas/app/data/models/home_model.dart';
import 'package:tarefas/app/ui/widgets/custom_icon_button.dart';
import 'package:tarefas/app/ui/android/home/widgets/custom_show_dialog.dart';
import 'package:tarefas/app/ui/widgets/custom_text_field.dart';
import 'package:tarefas/app/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();

  final List<HomeModel> items = <HomeModel>[];

  final TextEditingController textController = TextEditingController();

  _formatDate(String date) {
    initializeDateFormatting("pt_BR");
    var format = DateFormat("d/MM/y H:m:s");
    DateTime dateConvert = DateTime.parse(date);
    String dateFormat = format.format(dateConvert);
    return dateFormat;
  }

  @override
  Widget build(BuildContext context) {
    List<HomeModel> _ultimaTarefaRemovida = <HomeModel>[];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.LOGIN,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        GetX<HomeController>(
                          init: HomeController(),
                          initState: (_) => _homeController.loadTask(),
                          builder: (homeController) => CustomTextField(
                            controller: textController,
                            hint: 'Tarefa',
                            onChanged: homeController.setNewTodoTitle,
                            suffix: homeController.isFormValid
                                ? CustomIconButton(
                                    radius: 32,
                                    iconData: Icons.add,
                                    onTap: () async {
                                      await homeController.addTask();
                                      homeController.loadTask();
                                      textController.clear();
                                      homeController.newTasksTitle = "";
                                      FocusScope.of(context).unfocus();
                                    },
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: GetBuilder<HomeController>(
                            builder: (homeController) {
                              return homeController.isListValid
                                  ? ListView.separated(
                                      itemCount:
                                          homeController.listModel.length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          background: Container(
                                            color: Colors.red,
                                            padding: EdgeInsets.all(16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                          direction:
                                              DismissDirection.startToEnd,
                                          confirmDismiss: (_) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text('Tem Certeza?'),
                                                content: Text(
                                                  'Deseja excluir a tarefa ${homeController.listModel[index].name}?',
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Não'),
                                                    onPressed: () {
                                                      Navigator.of(ctx)
                                                          .pop(false);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Sim'),
                                                    onPressed: () {
                                                      Navigator.of(ctx)
                                                          .pop(true);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          onDismissed: (_) {
                                            _ultimaTarefaRemovida =
                                                homeController.listModel;
                                            homeController.dellTask(
                                                homeController
                                                    .listModel[index].id!);
                                            homeController.loadTask();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        "Tarefa ${homeController.listModel[index].name} excluida",
                                                  ),
                                                ),
                                                duration: Duration(seconds: 2),
                                                action: SnackBarAction(
                                                  label: 'DESFAZER',
                                                  onPressed: () {
                                                    items.insert(
                                                        index,
                                                        _ultimaTarefaRemovida[
                                                            index]);

                                                    homeController.addTask(
                                                        recover:
                                                            _ultimaTarefaRemovida[
                                                                index]);
                                                    homeController.loadTask();
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          key: UniqueKey(),
                                          child: ListTile(
                                            title: Text(
                                              homeController
                                                  .listModel[index].name,
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            subtitle: Text(
                                              "${_formatDate(homeController.listModel[index].date)}",
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await showDialog(
                                                          context: context,
                                                          builder: (ctx) =>
                                                              CustomShowDialog(
                                                            task: homeController
                                                                    .listModel[
                                                                index],
                                                          ),
                                                        );
                                                        homeController
                                                            .loadTask();
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        color:
                                                            Colors.orange[800],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (_, __) {
                                        return Divider();
                                      },
                                    )
                                  : Center(child: Text("Não há anotações!!!"));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
