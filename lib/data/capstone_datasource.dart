import 'package:project/data/entities/telemetry_data.dart';
import 'package:project/data/entities/topics.dart';
import 'package:project/data/models/get_device_response.dart';
import 'package:project/data/models/get_telemetry_data_response.dart';
import 'package:project/data/models/get_topic_response.dart';
import 'package:project/data/models/publish_data_request.dart';
import 'package:project/data/services/capstone_service.dart';
import 'package:project/utils/app_utils.dart';

import 'entities/devices.dart';

abstract class CapstoneDataSources {
  factory CapstoneDataSources(CapstoneService capstoneService) =
      _CapstoneDataSourceImpl;
  Future<void> publishData({required PublishDataRequest body});
  Future<List<Topics>?> getTopics();
  Future<List<Devices>?> getDevices();
  Future<List<TelemetryData>?> getTelemetryData();

  Future<void> saveApiKey(String apiKey);
}

class _CapstoneDataSourceImpl implements CapstoneDataSources {
  final CapstoneService _capstoneService;
  _CapstoneDataSourceImpl(this._capstoneService);

  @override
  Future<List<Devices>?> getDevices() async {
    final response = await _capstoneService.getDevices();
    return response.devices;
  }

  @override
  Future<List<TelemetryData>?> getTelemetryData() async {
    final response = await _capstoneService.getTelemetryData();
    return response.data;
  }

  @override
  Future<List<Topics>?> getTopics() async {
    final response = await _capstoneService.getTopics();
    return response.topics;
  }

  @override
  Future<void> publishData({required PublishDataRequest body}) async =>
      await _capstoneService.postPublishData(body: body);

  @override
  Future<void> saveApiKey(String apiKey) async => AppUtils.saveApiKey(apiKey);
}
