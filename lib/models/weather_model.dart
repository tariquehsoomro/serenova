class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition
    });

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
    final temp = json["main"]["temp"];
    final tempC = temp - 273.15;

    return Weather(
      cityName: json["name"].toUpperCase(),
      temperature: tempC.toDouble(),
      mainCondition: json["weather"][0]["main"]
      );
    } catch (e) {
      return Weather(
        cityName: "",
        temperature: 0.0,
        mainCondition: ""
      );
    }
  }
}
