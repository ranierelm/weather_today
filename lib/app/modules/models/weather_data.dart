class WeatherData {
  final List<StateData> states;

  WeatherData({required this.states});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final statesList = json['result']['estados'] as List;
    final states =
        statesList.map((stateJson) => StateData.fromJson(stateJson)).toList();
    return WeatherData(states: states);
  }
}

class StateData {
  final String state;
  final List<DayData> days;

  StateData({required this.state, required this.days});

  factory StateData.fromJson(Map<String, dynamic> json) {
    final state = json['estado'];
    final daysList = json['dias'] as List;
    final days = daysList.map((dayJson) => DayData.fromJson(dayJson)).toList();
    return StateData(state: state, days: days);
  }
}

class DayData {
  final Map<String, List<TimeData>> day;

  DayData({required this.day});

  factory DayData.fromJson(Map<String, dynamic> json) {
    final Map<String, List<TimeData>> day = {};

    json.forEach((key, value) {
      final timeDataList = (value as List)
          .map((timeDataJson) => TimeData.fromJson(timeDataJson))
          .toList();
      day[key] = timeDataList;
    });

    return DayData(day: day);
  }
}

class TimeData {
  final List<WeatherInfo> morning;
  final List<WeatherInfo> afternoon;
  final List<WeatherInfo> evening;

  TimeData(
      {required this.morning, required this.afternoon, required this.evening});

  factory TimeData.fromJson(Map<String, dynamic> json) {
    final morningList = (json['manha'] as List)
        .map((infoJson) => WeatherInfo.fromJson(infoJson))
        .toList();
    final afternoonList = (json['tarde'] as List)
        .map((infoJson) => WeatherInfo.fromJson(infoJson))
        .toList();
    final eveningList = (json['noite'] as List)
        .map((infoJson) => WeatherInfo.fromJson(infoJson))
        .toList();

    return TimeData(
        morning: morningList, afternoon: afternoonList, evening: eveningList);
  }
}

class WeatherInfo {
  final String tempo;
  final String graus;

  WeatherInfo({required this.tempo, required this.graus});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final tempo = json['tempo'];
    final graus = json['graus'].toString();
    return WeatherInfo(tempo: tempo, graus: graus);
  }
}
