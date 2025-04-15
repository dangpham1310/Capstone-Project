class Topics {
  Topics({
    num? id,
    String? name,
    String? description,
    String? createdAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _createdAt = createdAt;
  }

  Topics.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _createdAt = json['created_at'];
  }
  num? _id;
  String? _name;
  String? _description;
  String? _createdAt;
  Topics copyWith({
    num? id,
    String? name,
    String? description,
    String? createdAt,
  }) =>
      Topics(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    return map;
  }
}
