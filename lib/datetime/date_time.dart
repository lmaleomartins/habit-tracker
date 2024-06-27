// Roterna a data de hoje em fotmato de yyyymmdd
String todaysDateFormatted() {
  // Hoje
  var dateTimeObject = DateTime.now();

  // Ano em formato yyyy
  String year = dateTimeObject.year.toString();

  // Mês em formato mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // Dia em formato dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Formato final
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

// Converte a string yyyymmdd para DateTime
DateTime createDateTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

// Converte DateTime para a string yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  // Ano em formato yyyy
  String year = dateTime.year.toString();

  // Mês em formato mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // Dia em formato dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Formato final
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
