import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/database_repository.dart';
import '../model/employee_model.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final DatabaseRepository repository;

  EmployeeCubit({required this.repository}) : super(EmployeeInitial());

  void fetchAllEmployeeList() {
    repository.getAllEmployee().then((emp) {
      emit(EmployeeLoaded(empList: emp));
    });
  }

  void addEmployeeData(EmployeeModel emp) {
    final currentState = state;

    if (currentState is EmployeeLoaded) {
      final empList = currentState.empList;
      empList.add(emp);
      emit(EmployeeLoaded(empList: empList));
    }
  }

  void updateEmployee(EmployeeModel emp) {
    final currentState = state;
    if (currentState is EmployeeLoaded) {
      for (int i = 0; i < currentState.empList.length; i++) {
        if (currentState.empList[i].id == emp.id) {
          currentState.empList[i] = emp;
        }
      }
      emit(EmployeeLoaded(empList: currentState.empList));
    }
  }

  void deleteEmployee(EmployeeModel emp) {
    repository.deleteEmployee(emp.id).then((isDeleted) {
      if (isDeleted == 1) {
        final currentState = state;
        if (currentState is EmployeeLoaded) {
          final empList = currentState.empList
              .where((element) => element.id != emp.id)
              .toList();
          emit(EmployeeDeleted(emp: emp));
          emit(EmployeeLoaded(empList: empList));
        }
      }
    });
  }

  void deleteEmployeeFromEditScreen(EmployeeModel emp) {
    final currentState = state;
    if (currentState is EmployeeLoaded) {
      final empList = currentState.empList
          .where((element) => element.id != emp.id)
          .toList();
      emit(EmployeeLoaded(empList: empList));
    }
  }

  void undoEmployeeData(EmployeeModel emp) {
    repository.insertEmployee(emp).then((value) {
      final currentState = state;
      if (value == emp.id) {
        if (currentState is EmployeeLoaded) {
          final empList = currentState.empList;
          empList.add(emp);
          emit(EmployeeLoaded(empList: empList));
        }
      }
    });
  }
}
