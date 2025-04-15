import 'package:project/data/entities/topics.dart';

class GetTopicResponse {
  GetTopicResponse({
    bool? success,
    List<Topics>? topics,
  }) {
    _success = success;
    _topics = topics;
  }

  GetTopicResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['topics'] != null) {
      _topics = [];
      json['topics'].forEach((v) {
        _topics?.add(Topics.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Topics>? _topics;
  GetTopicResponse copyWith({
    bool? success,
    List<Topics>? topics,
  }) =>
      GetTopicResponse(
        success: success ?? _success,
        topics: topics ?? _topics,
      );
  bool? get success => _success;
  List<Topics>? get topics => _topics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_topics != null) {
      map['topics'] = _topics?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
