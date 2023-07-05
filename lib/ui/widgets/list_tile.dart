import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/employee_cubit.dart';
import '../../model/employee_model.dart';

class TileWidget extends StatelessWidget {
  final EmployeeModel emp;
  final bool isCurrent;

  const TileWidget({
    super.key,
    required this.emp,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/edit_employee', arguments: emp),
      child: Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red[400],
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )),
          onDismissed: (direction) {
            BlocProvider.of<EmployeeCubit>(context).deleteEmployee(emp);
          },
          // confirmDismiss: (direction) async {
          // bool isdeleted = true;

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Row(
          //       children: [
          //         Text('Employee data has been deleted'),
          //         TextButton(
          //           onPressed: () async {
          //             // BlocProvider.of<EmployeeCubit>(context)
          //             //     .undoEmployeeData(emp);

          //             isdeleted = false;
          //           },
          //           child: Text('Undo'),
          //         )
          //       ],
          //     ),
          //     backgroundColor: Colors.black,
          //   ),
          // );
          //   BlocProvider.of<EmployeeCubit>(context).deleteEmployee(emp);
          //   return true;
          // },
          key: UniqueKey(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                emp.name!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                emp.designation!,
                style: const TextStyle(color: Color(0xFF949C9E)),
              ),
              const SizedBox(
                height: 5,
              ),
              isCurrent
                  ? Text(
                      'From' '${emp.startDate}',
                      style: const TextStyle(color: Color(0xFF949C9E)),
                    )
                  : Text(
                      '${emp.startDate} ' '-' ' ${emp.endDate}',
                      style: const TextStyle(color: Color(0xFF949C9E)),
                    )
            ]),
          )),
    );
  }
}
