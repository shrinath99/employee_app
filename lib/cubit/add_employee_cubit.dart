import 'package:employee_app/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/database_repository.dart';
import 'employee_cubit.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final DatabaseRepository repository;
  final EmployeeCubit employeeCubit;

  AddEmployeeCubit({required this.employeeCubit, required this.repository})
      : super(AddEmployeeInitial());

  void addEmployee(EmployeeModel emp) async {
    if (emp.name == "" || emp.designation == null || emp.startDate == null) {
      emit(AddEmployeeError(error: "enter the data"));
      return;
    }
    emit(AddEmployeeLoading());

    final result = await repository.insertEmployee(emp);

    if (result != null) {
      employeeCubit.addEmployeeData(emp);
      emit(EmployeeAdded());
    }
  }
}
