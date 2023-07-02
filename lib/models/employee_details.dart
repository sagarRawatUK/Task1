// To parse this JSON data, do
//
//     final employeeDetails = employeeDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

EmployeeDetails employeeDetailsFromJson(String str) =>
    EmployeeDetails.fromJson(json.decode(str));

String employeeDetailsToJson(EmployeeDetails data) =>
    json.encode(data.toJson());

class EmployeeDetails extends Equatable {
  final String employeeName;
  final String employeeRole;
  final String startDate;
  final String endDate;

  const EmployeeDetails({
    this.employeeName = '',
    this.employeeRole = '',
    this.startDate = '',
    this.endDate = '',
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(
        employeeName: json["employeeName"],
        employeeRole: json["employeeRole"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "employeeName": employeeName,
        "employeeRole": employeeRole,
        "startDate": startDate,
        "endDate": endDate,
      };

  @override
  List<Object?> get props => [
        employeeName,
        employeeRole,
        startDate,
        endDate,
      ];
}
