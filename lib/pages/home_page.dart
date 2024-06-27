import 'package:flutter/material.dart';
import 'package:habittrackertute/components/habit_tile.dart';
import 'package:habittrackertute/components/month_summary.dart';
import 'package:habittrackertute/components/my_fab.dart';
import 'package:habittrackertute/components/my_alert_box.dart';
import 'package:habittrackertute/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    // Se não tiver data, Abre o app pela 1° vez
    // Então cria a DB padrão
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // Se tiver data, então não é a 1° vez
    else {
      db.loadData();
    }

    // Carrega os dados
    db.updateDatabase();

    super.initState();
  }

  // Checkbock quando clicada
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][2] = value;
    });
    db.updateDatabase();
  }

  // Criar um novo Hábito
  final _newHabitNameController = TextEditingController();
  final _newHabitDescriptionController = TextEditingController();
  void createNewHabit() {
    // Diálogo de alerta para o user
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          nameController: _newHabitNameController,
          descriptionController: _newHabitDescriptionController,
          hintText: 'Hábito...',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // Salvar novo Hábito
  void saveNewHabit() {
    // Add na lista
    setState(() {
      db.todaysHabitList.add([
        _newHabitNameController.text,
        _newHabitDescriptionController.text,
        false
      ]);
    });

    // Limpar os campos de texto
    _newHabitNameController.clear();
    _newHabitDescriptionController.clear();
    // Pop
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // Cancelar
  void cancelDialogBox() {
    // Limpar os campos de texto
    _newHabitNameController.clear();
    _newHabitDescriptionController.clear();

    // Pop
    Navigator.of(context).pop();
  }

  // Abrir Config
  void openHabitSettings(int index) {
    _newHabitNameController.text = db.todaysHabitList[index][0];
    _newHabitDescriptionController.text = db.todaysHabitList[index][1];
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          nameController: _newHabitNameController,
          descriptionController: _newHabitDescriptionController,
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // Salvar com um novo nome e descrição
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
      db.todaysHabitList[index][1] = _newHabitDescriptionController.text;
    });
    _newHabitNameController.clear();
    _newHabitDescriptionController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // Deletar Hábito
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 249, 246),
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView(
        children: [
          // Mapa de Calor
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),

          // Lista de Hábitos
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitDescription: db.todaysHabitList[index][1],
                habitCompleted: db.todaysHabitList[index][2],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          )
        ],
      ),
    );
  }
}
