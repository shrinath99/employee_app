import 'package:employee_app/cubit/employee_cubit.dart';
import 'package:employee_app/database/database_repository.dart';
import 'package:employee_app/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_employee_state.dart';

class EditEmployeeCubit extends Cubit<EditEmployeeState> {
  final DatabaseRepository repository;
  final EmployeeCubit employeeCubit;

  EditEmployeeCubit({required this.repository, required this.employeeCubit})
      : super(EditEmployeeInitial());

  void deleteEmployee(EmployeeModel emp) {
    repository.deleteEmployee(emp.id).then((isdeleted) {
      if (isdeleted == 1) {
        employeeCubit.deleteEmployeeFromEditScreen(emp);
        emit(EmployeeEdited());
      }
    });
  }

  void updateEmployee(EmployeeModel emp) async {
    await repository.updateEmployee(emp).then((isEdited) {
      if (isEdited == 1) {
        employeeCubit.updateEmployee(emp);
        emit(EmployeeEdited());
      }
    });
  }
}
