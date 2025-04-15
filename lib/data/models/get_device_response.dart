import '../entities/devices.dart';

class GetDeviceResponse {
  GetDeviceResponse({
    bool? success,
    List<Devices>? devices,
  }) {
    _success = success;
    _devices = devices;
  }

  GetDeviceResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['devices'] != null) {
      _devices = [];
      json['devices'].forEach((v) {
        _devices?.add(Devices.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Devices>? _devices;
  GetDeviceResponse copyWith({
    bool? success,
    List<Devices>? devices,
  }) =>
      GetDeviceResponse(
        success: success ?? _success,
        devices: devices ?? _devices,
      );
  bool? get success => _success;
  List<Devices>? get devices => _devices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_devices != null) {
      map['devices'] = _devices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
