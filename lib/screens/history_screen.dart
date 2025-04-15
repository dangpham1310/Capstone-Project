import 'package:flutter/material.dart';
import 'package:project/model/history.dart';
import 'package:project/data_test/history_test.dart';
import 'package:project/widgets/history_weather_detail.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HistoryModel> list = listHistory;
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final history = list[index];
        final dateDisplay = history.date.difference(DateTime.now()).inDays == 0
            ? "Hôm nay"
            : history.date.difference(DateTime.now()).inDays == -1
                ? "Hôm qua"
                : "${(history.date.difference(DateTime.now()).inDays).abs()} ngày trước";
        return ListTile(
          title: Text(dateDisplay),
          subtitle: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: history.weathers
                  .map((weather) => HistoryWeatherDetail(weather: weather))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
