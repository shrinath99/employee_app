import 'package:employee_app/cubit/edit_employee_cubit.dart';
import 'package:employee_app/model/employee_model.dart';
import 'package:employee_app/ui/widgets/designation_title.dart';
import 'package:employee_app/ui/widgets/end_date_grid.dart';
import 'package:employee_app/ui/widgets/start_date_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class EditEmployeePage extends StatefulWidget {
  final EmployeeModel emp;
  const EditEmployeePage({super.key, required this.emp});

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  String? selectedItem1;

  DateTime todayDate = DateTime.now().toLocal();
  DateRangePickerController controller1 = DateRangePickerController();
  DateRangePickerController controller2 = DateRangePickerController();
  String? date;
  DateTime? tempDate;
  String tempDate2 = DateFormat('d MMM yyyy').format(DateTime.now()).toString();
  String tempDate3 = 'No date';

  final nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    DateTime todayDate = DateTime.now().toLocal();
    date = DateFormat('d MMM yyyy').format(todayDate);
    tempDate = DateFormat('d MMM yyyy').parse(date!);
    nameController.text = widget.emp.name!;
    selectedItem1 = widget.emp.designation;
    tempDate2 = widget.emp.startDate!;
    tempDate3 = widget.emp.endDate!;
    controller1.selectedDate =
        DateFormat('d MMM yyyy').parse(widget.emp.startDate!);
    widget.emp.endDate == "No date"
        ? controller2.selectedDate = null
        : controller2.selectedDate =
            DateFormat('d MMM yyyy').parse(widget.emp.endDate!);

    super.initState();
  }

  void _openMenu(BuildContext context) async {
    final selectedItem = await showModalBottomSheet<String>(
      backgroundColor: Colors.grey[600],
      context: context,
      builder: (BuildContext context) {
        return const DesignationTitleWidget();
      },
    );

    if (selectedItem != null) {
      setState(() {
        selectedItem1 = selectedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee Details'),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<EditEmployeeCubit>(context)
                  .deleteEmployee(widget.emp);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: BlocListener<EditEmployeeCubit, EditEmployeeState>(
        listener: (context, state) {
          if (state is EmployeeEdited) {
            Navigator.pop(context);
            return;
          } else if (state is EditEmployeeError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    size: 25.0,
                    color: Colors.blue,
                  ),
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Employee Name',
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE5E5E5)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _openMenu(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_bag_outlined),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        selectedItem1 ?? 'Select role',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        alertbox1(context: context, controller: controller1);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                tempDate2 ==
                                        DateFormat('d MMM yyyy')
                                            .format(DateTime.now())
                                    ? 'Today'
                                    : DateFormat('d MMM yyyy')
                                        .format(controller1.selectedDate!),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_right_alt_rounded,
                    size: 40,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        alertbox2(context: context, controller: controller2);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                tempDate3 == "No date"
                                    ? tempDate3
                                    : DateFormat('d MMM yyyy')
                                        .format(controller2.selectedDate!),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xffEDF8FF),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        final EmployeeModel emp = EmployeeModel(
                            name: nameController.text,
                            designation: selectedItem1,
                            startDate: tempDate2,
                            endDate: tempDate3,
                            id: widget.emp.id);

                        BlocProvider.of<EditEmployeeCubit>(context)
                            .updateEmployee(emp);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Center(
                        child:
                            BlocBuilder<EditEmployeeCubit, EditEmployeeState>(
                          builder: (context, state) {
                            if (state is EditEmployeeLoading) {
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                            return const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> alertbox1({
    required BuildContext context,
    required DateRangePickerController controller,
  }) {
    return showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, StateSetter setInnerState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.70,
              width: 600,
              child: Column(
                children: [
                  StartDateGridWidget(
                    controller: controller,
                    tempDate2: tempDate2,
                    todayDate: todayDate,
                    setInnerState: setInnerState,
                  ),
                  SfDateRangePicker(
                    headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center),
                    navigationMode: DateRangePickerNavigationMode.none,
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                        dayFormat: 'EEE'),
                    showNavigationArrow: true,
                    controller: controller,
                    onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                      setInnerState(() {
                        controller1.selectedDate =
                            dateRangePickerSelectionChangedArgs.value;
                        tempDate2 = DateFormat('d MMM yyyy')
                            .format(controller1.selectedDate!)
                            .toString();
                        print(tempDate2);
                      });

                      setState(() {
                        controller1.selectedDate =
                            dateRangePickerSelectionChangedArgs.value;
                        tempDate2 = DateFormat('d MMM yyyy')
                            .format(controller1.selectedDate!)
                            .toString();
                        print(tempDate2);
                      });
                    },
                  ),
                  const Spacer(),
                  const Divider(
                    color: Color(0xffF2F2F2),
                    thickness: 2.0,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.badge),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(tempDate2),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xffEDF8FF),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            tempDate2 = DateFormat('d MMM yyyy')
                                .format(controller.selectedDate!);
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> alertbox2({
    required BuildContext context,
    required DateRangePickerController controller,
  }) {
    return showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, StateSetter setInnerState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.70,
              width: 600,
              child: Column(
                children: [
                  EndDateGridWidget(
                    controller: controller,
                    tempDate3: tempDate3,
                    todayDate: todayDate,
                    setInnerState: setInnerState,
                  ),
                  SfDateRangePicker(
                    headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center),
                    navigationMode: DateRangePickerNavigationMode.none,
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                        dayFormat: 'EEE'),
                    showNavigationArrow: true,
                    controller: controller,
                    onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                      setInnerState(() {
                        controller2.selectedDate =
                            dateRangePickerSelectionChangedArgs.value;

                        if (controller2.selectedDate != null) {
                          tempDate3 = DateFormat('d MMM yyyy')
                              .format(controller2.selectedDate!)
                              .toString();
                        }
                      });
                      setState(() {
                        controller2.selectedDate =
                            dateRangePickerSelectionChangedArgs.value;

                        if (controller2.selectedDate != null) {
                          tempDate3 = DateFormat('d MMM yyyy')
                              .format(controller2.selectedDate!)
                              .toString();
                        } else {
                          tempDate3 = "No date";
                        }
                      });
                    },
                    toggleDaySelection: true,
                  ),
                  const Spacer(),
                  const Divider(
                    color: Color(0xffF2F2F2),
                    thickness: 2.0,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(
                        width: 8,
                      ),
                      tempDate3.isEmpty
                          ? const Text('No date')
                          : Text(tempDate3),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xffEDF8FF),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            if (tempDate3 == 'No date') {
                              tempDate3 = 'No date';
                            } else {
                              tempDate3 = DateFormat('d MMM yyyy')
                                  .format(controller.selectedDate!);
                            }

                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
