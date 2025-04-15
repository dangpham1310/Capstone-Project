import 'package:flutter/material.dart';
import 'package:project/model/schedule.dart';
import 'package:wheel_picker/wheel_picker.dart';
import 'package:project/pages/repeat_schedule_page.dart';
import 'package:project/widgets/schedule_option_row.dart';

class ChangeSchedulePage extends StatefulWidget {
  const ChangeSchedulePage({super.key, required this.scheduleModel});

  final ScheduleModel scheduleModel;

  @override
  State<ChangeSchedulePage> createState() => _ChangeSchedulePageState();
}

class _ChangeSchedulePageState extends State<ChangeSchedulePage> {
  late WheelPickerController _hourController;
  late WheelPickerController _minuteController;
  late bool isRepeat;

  @override
  void initState() {
    super.initState();
    _hourController = WheelPickerController(
        itemCount: 23, initialIndex: widget.scheduleModel.timeOfDay.hour - 1);
    _minuteController = WheelPickerController(
        itemCount: 59, initialIndex: widget.scheduleModel.timeOfDay.minute - 1);
    isRepeat = widget.scheduleModel.isRepat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sửa Scheduler',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
            ),
          ),
        ),
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Hủy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (widget.scheduleModel.timeOfDay.hour ==
                      _hourController.selected &&
                  widget.scheduleModel.timeOfDay.minute ==
                      _minuteController.selected) {
                Navigator.pop(context);
              } else {
                TimeOfDay(
                    hour: _hourController.selected,
                    minute: _minuteController.selected);
                Navigator.pop(
                    context,
                    TimeOfDay(
                        hour: _hourController.selected + 1,
                        minute: _minuteController.selected + 1));
              }
            },
            child: Text(
              'Lưu',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 30,
                  child: WheelPicker(
                    controller: _hourController,
                    builder: (context, index) => Text(
                      (index < 9 ? '0' : '') + (index + 1).toString(),
                      style: TextStyle(fontSize: 22),
                    ),
                    selectedIndexColor: Color(0xFF1E90FF),
                    looping: true,
                    style: WheelPickerStyle(itemExtent: 25),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 250,
                  width: 30,
                  child: WheelPicker(
                    controller: _minuteController,
                    builder: (context, index) => Text(
                      (index < 9 ? '0' : '') + (index + 1).toString(),
                      style: TextStyle(fontSize: 22),
                    ),
                    selectedIndexColor: Color(0xFF1E90FF),
                    looping: true,
                    style: WheelPickerStyle(itemExtent: 25),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ScheduleOptionRow(
                    title: 'Lặp lại',
                    value: 'Hàng ngày',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RepeatSchedulePage(),
                      ),
                    ),
                  ),
                  Divider(),
                  ScheduleOptionRow(
                    title: 'Nhãn',
                    value: widget.scheduleModel.description,
                    onTap: () {},
                  ),
                  // Divider(),
                  // ScheduleOptionRow(
                  //   title: 'Âm thanh',
                  //   value: 'Hướng tâm',
                  //   onTap: () {},
                  // ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'Tưới Lại',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      StatefulBuilder(builder: (context, setStateBuilder) {
                        return Switch(
                          value: isRepeat,
                          onChanged: (change) {
                            setStateBuilder(() {
                              isRepeat = change;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  'Xóa',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
