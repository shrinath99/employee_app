part of 'add_employee_cubit.dart';

@immutable
abstract class AddEmployeeState {}

class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeError extends AddEmployeeState {
  final String error;

  AddEmployeeError({required this.error});
}

class AddEmployeeLoading extends AddEmployeeState {}

class EmployeeAdded extends AddEmployeeState {}
