import 'package:isar/isar.dart';

part 'employee.g.dart';

@collection
class Employee {
  Id id = Isar.autoIncrement;

  String? employeeName;

  String? employeeRole;

  String? startDate;

  String? endDate;

  bool? isCurrentEmployee;
}
