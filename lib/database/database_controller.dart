import 'package:employee_app/model/employee_model.dart';

import 'database_provider.dart';

class DatabaseController {
  final dbClient = DatabaseProvider.dbProvider;

  Future<int> addEmployeeData(EmployeeModel emp) async {
    final db = await dbClient.db;
    var result = db.insert("employeeTable", emp.toJSON());

    return result;
  }

  Future<List<EmployeeModel>> getAllEmployee({List<String>? columns}) async {
    final db = await dbClient.db;
    var result = await db.query("employeeTable", columns: columns);
    List<EmployeeModel> empData = result.isNotEmpty
        ? result.map((item) => EmployeeModel.fromJSON(item)).toList()
        : [];

    return empData;
  }

  Future<int> updateEmployee(EmployeeModel emp) async {
    final db = await dbClient.db;

    var result = await db.update("employeeTable", emp.toJSON(),
        where: "id = ?", whereArgs: [emp.id]);
    return result;
  }

  Future<int> deleteEmployee(int id) async {
    final db = await dbClient.db;
    var result =
        await db.delete("employeeTable", where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
