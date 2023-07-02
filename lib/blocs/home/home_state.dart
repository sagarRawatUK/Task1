part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.employeeName = '',
    this.employeeRole = '',
    this.endDate = '',
    this.startDate = '',
    this.previousEmployee = const [],
    this.currentEmployee = const [],
  });

  final String employeeName;
  final String employeeRole;
  final String startDate;
  final String endDate;
  final List<Employee> previousEmployee;
  final List<Employee> currentEmployee;

  @override
  List<Object?> get props => [
        employeeName,
        employeeRole,
        startDate,
        endDate,
        previousEmployee,
        currentEmployee,
      ];

  factory HomeState.initial() => const HomeState(
        employeeName: '',
        employeeRole: '',
        endDate: '',
        startDate: '',
        previousEmployee: [],
        currentEmployee: [],
      );

  HomeState copyWith({
    String? employeeName,
    String? employeeRole,
    String? endDate,
    String? startDate,
    List<Employee>? previousEmployee,
    List<Employee>? currentEmployee,
  }) {
    return HomeState(
      employeeName: employeeName ?? this.employeeName,
      employeeRole: employeeRole ?? this.employeeRole,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      previousEmployee: previousEmployee ?? this.previousEmployee,
      currentEmployee: currentEmployee ?? this.currentEmployee,
    );
  }
}
