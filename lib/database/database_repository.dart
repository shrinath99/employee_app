import '../model/employee_model.dart';
import 'database_controller.dart';

class DatabaseRepository {
  final DatabaseController dbController = DatabaseController();

  Future getAllEmployee() => dbController.getAllEmployee();

  Future insertEmployee(EmployeeModel emp) => dbController.addEmployeeData(emp);

  Future updateEmployee(EmployeeModel emp) => dbController.updateEmployee(emp);

  Future deleteEmployee(int id) => dbController.deleteEmployee(id);
}
