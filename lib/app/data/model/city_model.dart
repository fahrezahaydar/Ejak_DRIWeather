import 'package:latlong2/latlong.dart';
import 'package:nominatim_flutter/model/response/nominatim_response.dart';

class CityModel {
  final String name;
  final LatLng position;

  CityModel({required this.name, required this.position});

  static List<CityModel> fromNominatism(List<NominatimResponse> data) {
    return List.generate(data.length, (int index) {
      return CityModel(
        name: data[index].address!["city"],
        position: LatLng(
          double.parse(data[index].lat!),
          double.parse(data[index].lon!),
        ),
      );
    });
  }
}
