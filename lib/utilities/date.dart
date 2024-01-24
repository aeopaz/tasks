class CustomDateFormat {
  CustomDateFormat({required this.date});

  final String date;

// Calcula minutos, horas y días entre una fecha cualquiera y la actual
  Map<String, int> diffForHumans() {
    DateTime startDate = DateTime.parse(date);
    DateTime endDate = DateTime.now();

    int diffInMilliseconds =
        endDate.millisecondsSinceEpoch - startDate.millisecondsSinceEpoch;
    int elapsedMinutes = (diffInMilliseconds ~/ (1000 * 60)).floor();
    int elapsedHours = (diffInMilliseconds ~/ (1000 * 60 * 60)).floor();
    int elapsedDays = (diffInMilliseconds ~/ (1000 * 60 * 60 * 24)).floor();

    return {
      'minutes': elapsedMinutes,
      'hours': elapsedHours,
      'days': elapsedDays,
    };
  }

//Calcula días de vencimiento de una tarea
  String vencimiento() {
    Map<String, int> diff = diffForHumans();
    int minutes = diff['minutes']!;
    int hours = diff['hours']!;
    int days = diff['days']!;

    if (days < 0) return 'Vence en $days';
    if (days == 0) return 'Vence hoy';
    return 'Vencida hace $days días';
  }
}
