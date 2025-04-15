import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/model/device.dart';
import 'package:project/model/schedule.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/pages/change_schedule_page.dart';
import 'package:project/widgets/schedule_list_item.dart';

class ListStationScreen extends StatefulWidget {
  const ListStationScreen({super.key});

  @override
  State<ListStationScreen> createState() => _ListStationScreenState();
}

class _ListStationScreenState extends State<ListStationScreen> {
  List<DeviceModel> _devices = [];
  bool _isLoading = true;
  String? _error;
  DeviceModel? _selectedDevice;

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }

  Future<void> _fetchDevices() async {
    try {
      final apiKey = AuthService().getApiKey();
      if (apiKey == null) {
        setState(() {
          _error = 'Vui lòng đăng nhập lại';
          _isLoading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('https://iot.karis.cloud/api/devices'),
        headers: {
          'Content-Type': 'application/json',
          'X-API-Key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final devices = (data['devices'] as List)
            .map((device) => DeviceModel.fromJson(device))
            .toList();
        setState(() {
          _devices = devices;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Không thể tải danh sách thiết bị';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Có lỗi xảy ra: $e';
        _isLoading = false;
      });
    }
  }

  Widget _buildDeviceCard(DeviceModel device) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1387DA).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color(0xFF1387DA).withOpacity(0.1),
              ],
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedDevice = device;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF1387DA).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.device_hub,
                          color: Color(0xFF1387DA),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          device.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1387DA),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Mô tả', device.description),
                        SizedBox(height: 8),
                        _buildInfoRow(
                          'Trạng thái',
                          device.lastSeen != null
                              ? 'Đang hoạt động'
                              : 'Không hoạt động',
                          icon: device.lastSeen != null
                              ? Icons.check_circle
                              : Icons.cancel,
                          iconColor: device.lastSeen != null
                              ? Colors.green
                              : Colors.red,
                        ),
                        if (device.lastSeen != null) ...[
                          SizedBox(height: 8),
                          _buildInfoRow(
                            'Lần hoạt động cuối',
                            device.lastSeen!,
                            icon: Icons.access_time,
                            iconColor: Colors.orange,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleList(DeviceModel device) {
    // Tạm thời sử dụng danh sách lịch mẫu
    final schedules = [
      ScheduleModel(
        description: 'Bật đèn',
        timeOfDay: TimeOfDay(hour: 6, minute: 0),
        isDone: false,
        isRepat: true,
      ),
      ScheduleModel(
        description: 'Tưới cây',
        timeOfDay: TimeOfDay(hour: 8, minute: 0),
        isDone: false,
        isRepat: true,
      ),
      ScheduleModel(
        description: 'Tắt đèn',
        timeOfDay: TimeOfDay(hour: 18, minute: 0),
        isDone: false,
        isRepat: true,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _selectedDevice = null;
        });
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Color(0xFF1387DA).withOpacity(0.05),
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: schedules.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ScheduleListItem(
                      schedule: schedule,
                      onTap: () async {
                        final newTime = await Navigator.push<TimeOfDay>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeSchedulePage(
                              scheduleModel: schedule,
                            ),
                          ),
                        );
                        if (newTime != null) {
                          setState(() {
                            schedule.timeOfDay = newTime;
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF1387DA)),
                  onPressed: () {
                    setState(() {
                      _selectedDevice = null;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeSchedulePage(
                  scheduleModel: ScheduleModel(
                    description: '',
                    timeOfDay: TimeOfDay.now(),
                    isDone: false,
                    isRepat: true,
                  ),
                ),
              ),
            );
          },
          backgroundColor: Color(0xFF1387DA),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {IconData? icon, Color? iconColor}) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
          SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchDevices,
              child: Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (_selectedDevice != null) {
      return _buildScheduleList(_selectedDevice!);
    }

    return Container(
      color: Color(0xFF1387DA).withOpacity(0.05),
      child: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          return _buildDeviceCard(_devices[index]);
        },
      ),
    );
  }
}
