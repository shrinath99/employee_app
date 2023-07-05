class EmployeeModel {
  String? name;
  String? designation;
  String? startDate;
  String? endDate;
  int id;

  EmployeeModel(
      {this.name,
      this.designation,
      this.startDate,
      this.endDate,
      required this.id});

  Map<String, dynamic> toJSON() => {
        'name': name,
        'designation': designation,
        'startDate': startDate,
        'endDate': endDate,
        'id': id
      };

  factory EmployeeModel.fromJSON(Map<String, dynamic> json) {
    return EmployeeModel(
        name: json['name'],
        designation: json['designation'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        id: json['id']);
  }
}
