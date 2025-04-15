import 'package:project/model/device.dart';
import 'package:project/data_test/weather_test.dart';
import 'package:project/data_test/schedule_test.dart';

final listDevice = [
  DeviceModel(
    id: 1,
    clientId: 1,
    name: 'test_device_1',
    description: 'Auto-created device for test_device_1',
    createdAt: '2025-03-23 01:06:12',
    lastSeen: '2025-03-23T04:00:08.345720',
  ),
  DeviceModel(
    id: 2,
    clientId: 1,
    name: 'mqtt_test_device',
    description: 'Auto-created device for mqtt_test_device',
    createdAt: '2025-03-23 01:06:30',
    lastSeen: '2025-03-23T01:06:47.859168',
  ),
  DeviceModel(
    id: 3,
    clientId: 1,
    name: 'nonexistent_device',
    description: 'Auto-created device for nonexistent_device',
    createdAt: '2025-03-23 02:11:13',
    lastSeen: null,
  ),
];
