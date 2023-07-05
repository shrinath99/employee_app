import 'package:employee_app/cubit/edit_employee_cubit.dart';
import 'package:employee_app/model/employee_model.dart';
import 'package:employee_app/ui/employee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_employee_cubit.dart';
import '../cubit/employee_cubit.dart';
import '../database/database_repository.dart';
import '../ui/employee_edit_page.dart';
import '../ui/employee_form_page.dart';

class EmployeeRouter {
  DatabaseRepository repository = DatabaseRepository();
  EmployeeCubit employeeCubit;

  EmployeeRouter({required this.repository, required this.employeeCubit});

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/ ":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: employeeCubit,
            child: EmployeeList(),
          ),
        );
      case "/add_employee":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddEmployeeCubit(
                    repository: repository,
                    employeeCubit: employeeCubit,
                  ),
                  child: const EmployeeFormPage(),
                ));
      case "/edit_employee":
        final emp = settings.arguments as EmployeeModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => EditEmployeeCubit(
                    repository: repository,
                    employeeCubit: employeeCubit,
                  ),
                  child: EditEmployeePage(
                    emp: emp,
                  ),
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: employeeCubit,
            child: EmployeeList(),
          ),
        );
    }
  }
}
