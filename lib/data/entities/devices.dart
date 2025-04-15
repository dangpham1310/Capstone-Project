class Devices {
  Devices({
    num? id,
    String? name,
    String? description,
    num? clientId,
    String? lastSeen,
    String? createdAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _clientId = clientId;
    _lastSeen = lastSeen;
    _createdAt = createdAt;
  }

  Devices.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _clientId = json['client_id'];
    _lastSeen = json['last_seen'];
    _createdAt = json['created_at'];
  }
  num? _id;
  String? _name;
  String? _description;
  num? _clientId;
  String? _lastSeen;
  String? _createdAt;
  Devices copyWith({
    num? id,
    String? name,
    String? description,
    num? clientId,
    String? lastSeen,
    String? createdAt,
  }) =>
      Devices(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        clientId: clientId ?? _clientId,
        lastSeen: lastSeen ?? _lastSeen,
        createdAt: createdAt ?? _createdAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get clientId => _clientId;
  String? get lastSeen => _lastSeen;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['client_id'] = _clientId;
    map['last_seen'] = _lastSeen;
    map['created_at'] = _createdAt;
    return map;
  }
}
