// ignore_for_file: must_be_immutable

import 'package:employee_app/ui/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class StartDateGridWidget extends StatefulWidget {
  DateRangePickerController controller;
  DateTime todayDate;
  String tempDate2;
  StateSetter setInnerState;
  StartDateGridWidget(
      {super.key,
      required this.controller,
      required this.todayDate,
      required this.tempDate2,
      required this.setInnerState});

  @override
  State<StartDateGridWidget> createState() => _StartDateGridWidgetState();
}

class _StartDateGridWidgetState extends State<StartDateGridWidget> {
  int activeButtonIndexStartDate = -1;
  List<String> textTitle = [
    'Today',
    'Next Monday',
    'Next Tuesday',
    'After 1 week',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: List.generate(4, (index) {
          return ToggleButton(
              active: activeButtonIndexStartDate == index,
              onTap: () {
                setState(() {
                  activeButtonIndexStartDate = index;
                  widget.setInnerState(() {
                    if (activeButtonIndexStartDate == 0) {
                      widget.setInnerState(() {
                        widget.controller.selectedDate = widget.todayDate;
                      });
                    } else if (activeButtonIndexStartDate == 1) {
                      int daysUntilNextMonday =
                          DateTime.monday - widget.todayDate.weekday + 7;
                      widget.controller.selectedDate =
                          widget.todayDate.add(Duration(
                        days: (daysUntilNextMonday),
                      ));
                    } else if (activeButtonIndexStartDate == 2) {
                      int daysUntilNextTuesday =
                          DateTime.tuesday - widget.todayDate.weekday + 7;

                      widget.setInnerState(() {
                        widget.controller.selectedDate =
                            widget.todayDate.add(Duration(
                          days: (daysUntilNextTuesday),
                        ));

                        widget.tempDate2 = DateFormat('d MMM yyyy')
                            .format(widget.controller.selectedDate!);
                      });
                    } else if (activeButtonIndexStartDate == 3) {
                      widget.setInnerState(() {
                        widget.controller.selectedDate =
                            widget.todayDate.add(Duration(days: 7));

                        widget.tempDate2 = DateFormat('d MMM yyyy')
                            .format(widget.controller.selectedDate!);
                      });
                    }
                  });
                });
              },
              text: textTitle[index]);
        }));
  }
}
