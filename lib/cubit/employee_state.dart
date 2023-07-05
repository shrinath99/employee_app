part of 'employee_cubit.dart';

@immutable
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<EmployeeModel> empList;

  EmployeeLoaded({required this.empList});
}

class EmployeeDeleted extends EmployeeState {
  final EmployeeModel emp;

  EmployeeDeleted({required this.emp});
}
