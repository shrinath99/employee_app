// import 'package:employee_app/model/employee_model.dart';
// import 'package:employee_app/ui/employee_form_page.dart';
import 'package:employee_app/database/database_repository.dart';
import 'package:employee_app/router/employee_route.dart';
import 'package:flutter/material.dart';

import 'cubit/employee_cubit.dart';

void main() {
  runApp(EmployeeApp(
    router: EmployeeRouter(
        repository: DatabaseRepository(),
        employeeCubit: EmployeeCubit(
          repository: DatabaseRepository(),
        )),
  ));
}

class EmployeeApp extends StatelessWidget {
  final EmployeeRouter router;

  const EmployeeApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
    );

  }
}
