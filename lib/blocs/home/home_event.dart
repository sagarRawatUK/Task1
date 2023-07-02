part of 'home_bloc.dart';

class HomeEvent {}

class HomePageOnstart extends HomeEvent {}

class InitIsar extends HomeEvent {}

class EmployeeNameChangedEvent extends HomeEvent {
  final String employeeName;
  EmployeeNameChangedEvent({required this.employeeName});
}

class EmployeeRoleChangedEvent extends HomeEvent {
  final String employeeRole;
  EmployeeRoleChangedEvent({required this.employeeRole});
}

class StartDateChangedEvent extends HomeEvent {
  final String startDate;
  StartDateChangedEvent({required this.startDate});
}

class EndDateChangedEvent extends HomeEvent {
  final String endDate;
  EndDateChangedEvent({required this.endDate});
}

class SaveEmployeeData extends HomeEvent {
  final String employeeId;
  SaveEmployeeData({required this.employeeId});
}

class DeleteEmployeeData extends HomeEvent {
  String employeeId;
  DeleteEmployeeData({required this.employeeId});
}

class EditEmployeeData extends HomeEvent {}

class ClearEmployeeData extends HomeEvent {}
