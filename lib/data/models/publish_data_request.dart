class PublishDataRequest {
  PublishDataRequest({
      String? device, 
      String? topic, 
      Payload? payload,}){
    _device = device;
    _topic = topic;
    _payload = payload;
}

  PublishDataRequest.fromJson(dynamic json) {
    _device = json['device'];
    _topic = json['topic'];
    _payload = json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }
  String? _device;
  String? _topic;
  Payload? _payload;
PublishDataRequest copyWith({  String? device,
  String? topic,
  Payload? payload,
}) => PublishDataRequest(  device: device ?? _device,
  topic: topic ?? _topic,
  payload: payload ?? _payload,
);
  String? get device => _device;
  String? get topic => _topic;
  Payload? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device'] = _device;
    map['topic'] = _topic;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }

}

class Payload {
  Payload({
      num? value, 
      String? unit, 
      num? timestamp,}){
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
Payload copyWith({  num? value,
  String? unit,
  num? timestamp,
}) => Payload(  value: value ?? _value,
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