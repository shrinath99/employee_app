part of 'edit_employee_cubit.dart';

@immutable
abstract class EditEmployeeState {}

class EditEmployeeInitial extends EditEmployeeState {}

class EditEmployeeError extends EditEmployeeState {
  final String error;

  EditEmployeeError({required this.error});
}

class EmployeeEdited extends EditEmployeeState {}

class EditEmployeeLoading extends EditEmployeeState {}
