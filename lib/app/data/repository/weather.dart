import '../../services/networks/api_services.dart';

enum ForecastTimesteps { hourly, daily }

abstract class WeatherRepository {
  Future<dynamic> getRealtimeData(String loc);
  Future<dynamic> getForeCastData(String loc, ForecastTimesteps timestep);
}

class WeatherRepoImpl implements WeatherRepository {
  WeatherRepoImpl(this._apiServices);

  final String apiKey = "&apikey=bsZIQSOnyE3NwQtsikwNSQNKExjVcJOJ";
  final String web = "https://api.tomorrow.io/v4/weather";

  final headers = {
    'accept': 'application/json',
    'accept-encoding': 'deflate, gzip, br',
  };
  final ApiServices _apiServices;

  @override
  Future getRealtimeData(String loc) async {
    try {
      final res =
          await _apiServices.get("$web/realtime?location=$loc$apiKey", headers);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getForeCastData(String loc, ForecastTimesteps timestep) async {
    String string;
    if (timestep == ForecastTimesteps.hourly) {
      string = "1h";
    } else {
      string = "1d";
    }
    String url = "$web/forecast?location=$loc&timesteps=$string$apiKey";
    final res = await _apiServices.get(
      url,
      headers,
    );
    return res;
  }
}
