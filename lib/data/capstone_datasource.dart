import 'package:project/data/entities/telemetry_data.dart';
import 'package:project/data/entities/topics.dart';
import 'package:project/data/models/get_device_response.dart';
import 'package:project/data/models/get_telemetry_data_response.dart';
import 'package:project/data/models/get_topic_response.dart';
import 'package:project/data/services/capstone_service.dart';

import 'entities/devices.dart';

abstract class CapstoneDataSources {
  Future<void> publishData();
  Future<List<Topics>> getTopics();
  Future<List<Devices>> getDevices();
  Future<List<TelemetryData>> getTelemetryData();
}

class _CapstoneDataSourceImpl implements CapstoneDataSources {
  final CapstoneService _capstoneService;
  _CapstoneDataSourceImpl(this._capstoneService);

  @override
  Future<List<Devices>> getDevices() {
    // TODO: implement getDevices
    throw UnimplementedError();
  }

  @override
  Future<List<TelemetryData>> getTelemetryData() {
    // TODO: implement getTelemetryData
    throw UnimplementedError();
  }

  @override
  Future<List<Topics>> getTopics() {
    // TODO: implement getTopics
    throw UnimplementedError();
  }

  @override
  Future<void> publishData() {
    // TODO: implement publishData
    throw UnimplementedError();
  }
}
