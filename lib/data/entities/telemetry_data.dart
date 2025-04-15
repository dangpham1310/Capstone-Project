class TelemetryData {
  TelemetryData({
    num? id,
    num? deviceId,
    String? deviceName,
    num? topicId,
    String? topicName,
    Payload? payload,
    String? timestamp,
  }) {
    _id = id;
    _deviceId = deviceId;
    _deviceName = deviceName;
    _topicId = topicId;
    _topicName = topicName;
    _payload = payload;
    _timestamp = timestamp;
  }

  TelemetryData.fromJson(dynamic json) {
    _id = json['id'];
    _deviceId = json['device_id'];
    _deviceName = json['device_name'];
    _topicId = json['topic_id'];
    _topicName = json['topic_name'];
    _payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    _timestamp = json['timestamp'];
  }
  num? _id;
  num? _deviceId;
  String? _deviceName;
  num? _topicId;
  String? _topicName;
  Payload? _payload;
  String? _timestamp;
  TelemetryData copyWith({
    num? id,
    num? deviceId,
    String? deviceName,
    num? topicId,
    String? topicName,
    Payload? payload,
    String? timestamp,
  }) =>
      TelemetryData(
        id: id ?? _id,
        deviceId: deviceId ?? _deviceId,
        deviceName: deviceName ?? _deviceName,
        topicId: topicId ?? _topicId,
        topicName: topicName ?? _topicName,
        payload: payload ?? _payload,
        timestamp: timestamp ?? _timestamp,
      );
  num? get id => _id;
  num? get deviceId => _deviceId;
  String? get deviceName => _deviceName;
  num? get topicId => _topicId;
  String? get topicName => _topicName;
  Payload? get payload => _payload;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['device_id'] = _deviceId;
    map['device_name'] = _deviceName;
    map['topic_id'] = _topicId;
    map['topic_name'] = _topicName;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    map['timestamp'] = _timestamp;
    return map;
  }
}

class Payload {
  Payload({
    num? value,
    String? unit,
    num? timestamp,
  }) {
    _value = value;
    _unit = unit;
    _timestamp = timestamp;
  }

  Payload.fromJson(dynamic json) {
    _value = json['value'];
    _unit = json['unit'];
    _timestamp = json['timestamp'];
  }
  num? _value;
  String? _unit;
  num? _timestamp;
  Payload copyWith({
    num? value,
    String? unit,
    num? timestamp,
  }) =>
      Payload(
        value: value ?? _value,
        unit: unit ?? _unit,
        timestamp: timestamp ?? _timestamp,
      );
  num? get value => _value;
  String? get unit => _unit;
  num? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['unit'] = _unit;
    map['timestamp'] = _timestamp;
    return map;
  }
}
