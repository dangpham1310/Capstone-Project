import 'package:project/data/entities/telemetry_data.dart';

class GetTelemetryDataResponse {
  GetTelemetryDataResponse({
    bool? success,
    List<TelemetryData>? data,
  }) {
    _success = success;
    _data = data;
  }

  GetTelemetryDataResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TelemetryData.fromJson(v));
      });
    }
  }
  bool? _success;
  List<TelemetryData>? _data;
  GetTelemetryDataResponse copyWith({
    bool? success,
    List<TelemetryData>? data,
  }) =>
      GetTelemetryDataResponse(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  List<TelemetryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
