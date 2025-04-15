import 'package:flutter/material.dart';
import 'package:project/model/device.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key, required this.deviceModel});

  final DeviceModel deviceModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          deviceModel.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1387DA),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1387DA).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Color(0xFF1387DA).withOpacity(0.3),
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
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.device_hub,
                            size: 30,
                            color: Color(0xFF1387DA),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Thông tin thiết bị',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1387DA),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildInfoRow('ID', deviceModel.id.toString()),
                      _buildInfoRow(
                          'Client ID', deviceModel.clientId.toString()),
                      _buildInfoRow('Tên', deviceModel.name),
                      _buildInfoRow('Mô tả', deviceModel.description),
                      _buildInfoRow('Ngày tạo', deviceModel.createdAt),
                      _buildInfoRow('Lần hoạt động cuối',
                          deviceModel.lastSeen ?? 'Chưa hoạt động'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            padding: EdgeInsets.only(right: 10),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1387DA),
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
