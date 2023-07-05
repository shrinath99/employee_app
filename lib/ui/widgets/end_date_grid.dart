// ignore_for_file: must_be_immutable

import 'package:employee_app/ui/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EndDateGridWidget extends StatefulWidget {
  DateRangePickerController controller;
  final DateTime todayDate;
  String tempDate3;
  StateSetter setInnerState;
  EndDateGridWidget(
      {super.key,
      required this.controller,
      required this.tempDate3,
      required this.todayDate,
      required this.setInnerState});

  @override
  State<EndDateGridWidget> createState() => _EndDateGridWidgetState();
}

class _EndDateGridWidgetState extends State<EndDateGridWidget> {
  int activeButtonIndexEndDate = -1;
  List<String> textTitle = [
    'No date',
    'Today',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: List.generate(2, (index) {
          return ToggleButton(
              active: activeButtonIndexEndDate == index,
              onTap: () {
                setState(() {
                  activeButtonIndexEndDate = index;
                  widget.setInnerState(() {
                    if (activeButtonIndexEndDate == 0) {
                      widget.setInnerState(() {
                        widget.tempDate3 = "No date";
                        widget.controller.selectedDate = null;
                      });
                    } else if (activeButtonIndexEndDate == 1) {
                      widget.setInnerState(() {
                        widget.controller.selectedDate = widget.todayDate;
                      });
                    }
                  });
                });
              },
              text: textTitle[index]);
        }));
  }
}
