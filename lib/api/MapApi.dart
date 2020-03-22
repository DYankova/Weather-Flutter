
import'package:http/http.dart';
import 'package:my_weather_app/model/WeatherData.dart';

class MapApi {

  static const apiKey = '0eebe8cc598388ee476ca70d4a01a300';

  static const endPoint = 'http://api.openweathermap.org/data/2.5';
  double lat, lon;
  Client client = Client();

  static MapApi _instance;

  static MapApi getInstance() => _instance ??= MapApi();

  String _apiCall({double lat, double lon}) {
    return endPoint + "/weather?lat=" + lat.toString() +
        "&lon=" + lon.toString() + "&APPID=" + apiKey + "&units=metric";
  }

  getWeather({double lat, double lon}) async {
    var response = await client.get(
        Uri.encodeFull(_apiCall(lat: lat, lon: lon)),
        headers: {
          'Accept': 'application/json'
        }
    );
    return WeatherData.deserialize(response.body);
  }
}