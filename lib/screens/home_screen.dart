import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project/model/weather.dart';
import 'package:project/data_test/weather_test.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _index;
  late List<WeatherModel> _list;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _list = listWeather;
  }

  Widget _buildWeatherImage(WeatherModel weatherModel) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Image.asset(
        weatherModel.image,
        height: 200,
        width: 200,
      ),
    );
  }

  Widget _buildWeatherDescription(WeatherModel weatherModel) {
    return Text(
      weatherModel.description,
      style: TextStyle(
        fontSize: 24,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildWeatherTemperature(WeatherModel weatherModel) {
    return Text(
      '${weatherModel.temperature.toStringAsFixed(0)}°',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 48,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildWeatherChart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                  [18, 19, 24, 25, 26].length,
                  (index) => FlSpot(
                      index.toDouble(), [18.0, 19.0, 24.0, 25.0, 26.0][index])),
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.orange],
              ),
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherList() {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _list.asMap().entries.map((entry) {
            int index = entry.key;
            WeatherModel weather = entry.value;
            bool isSelected = index == _index;
            String time = weather.time <= 12
                ? '${weather.time}AM'
                : '${weather.time - 12}PM';
            String temperature = '${weather.temperature.toStringAsFixed(0)}°';
            return GestureDetector(
              onTap: () {
                setState(() {
                  _index = index;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey.shade300 : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        isSelected ? Colors.grey.shade300 : Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      time,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Image.asset(
                      weather.icon,
                      height: 36,
                      width: 36,
                    ),
                    SizedBox(height: 5),
                    Text(
                      temperature,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherModel = _list[_index];
    final listWidget = [
      _buildWeatherImage(weatherModel),
      _buildWeatherDescription(weatherModel),
      _buildWeatherTemperature(weatherModel),
      _buildWeatherChart(),
      _buildWeatherList(),
    ];
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFBCE8FF),
            Color(0xFFFFFFFF),
          ],
          stops: [0.0, 0.5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return listWidget[index];
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 20);
          },
          itemCount: 5),
    );
  }
}
