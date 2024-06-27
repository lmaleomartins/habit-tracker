import 'package:habittrackertute/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  // Dados iniciais padrão
  void createDefaultData() {
    todaysHabitList = [
      ["Ler um livro", "Ler 20 páginas de 1984", false],
      ["Correr", "Correr 5km no parque", false],
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // Carregar se existir
  void loadData() {
    // Se for um novo dia, pega o DB
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      // Seta todos o Hábitos como incompletos em um novo dia
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][2] = false;
      }
    }
    // Se for hoje, só carrega
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  // Att DB
  void updateDatabase() {
    // Att as entradas de hoje
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

    // Cálculo da porcentagem dos completos hoje
    calculateHabitPercentages();

    // Carrega o HeatMap
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][2] == true) {
        countCompleted++;
      }
    }

    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // Conta quantos dias para carregar
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );
      // Ano
      int year = startDate.add(Duration(days: i)).year;

      // Mês
      int month = startDate.add(Duration(days: i)).month;

      // Dia
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
