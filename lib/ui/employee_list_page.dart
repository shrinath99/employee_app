import 'package:employee_app/ui/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/employee_cubit.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EmployeeCubit>(context).fetchAllEmployeeList();

    return Scaffold(
      appBar: AppBar(title: const Text('Employee list')),
      body: BlocConsumer<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is! EmployeeLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final empList = (state).empList;

          if (empList.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 20),
                          color: Colors.grey[200],
                          child: const Text(
                            'Current employees',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: empList.map((currentEmp) {
                            if (currentEmp.endDate == "No date") {
                              return TileWidget(
                                emp: currentEmp,
                                isCurrent: true,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }).toList(),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 20),
                          color: Colors.grey[200],
                          child: const Text(
                            'Previous employees',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: empList.map((previousEmp) {
                            if (previousEmp.endDate != "No date") {
                              return TileWidget(
                                emp: previousEmp,
                                isCurrent: false,
                              );
                            } else {
                              return const SizedBox();
                            }
                          }).toList(),
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: const Text(
                            'Swipe left to delete',
                            style: TextStyle(color: Color(0xFF949C9E)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: Image.asset('assets/images/no-data.png'));
        },
        listener: (context, state) {
          if (state is EmployeeDeleted) {
            final emp = state.emp;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Employee data has been deleted'),
                    TextButton(
                      onPressed: () async {
                        BlocProvider.of<EmployeeCubit>(context)
                            .undoEmployeeData(emp);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      child: const Text(
                        'Undo',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.black87,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {},
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/add_employee");
          },
        ),
      ),
    );
  }
}
