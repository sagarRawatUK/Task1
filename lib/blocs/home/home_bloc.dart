import 'package:employeeapp/main.dart';
import 'package:employeeapp/models/employee.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Isar isar;
  HomeBloc() : super(HomeState.initial()) {
    on<InitIsar>((event, emit) async {
      final dir = await path_provider.getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [EmployeeSchema],
        directory: dir.path,
        inspector: true,
      );

      add(HomePageOnstart());
    });
    on<HomePageOnstart>((event, emit) async {
      final allEmployees = await isar.employees.where().findAll();

      List<Employee> currentEmlpoyee = [];
      List<Employee> previousEmployee = [];

      for (var employee in allEmployees) {
        if (employee.isCurrentEmployee ?? false) {
          currentEmlpoyee.add(employee);
        } else {
          previousEmployee.add(employee);
        }
      }

      emit(state.copyWith(
          previousEmployee: previousEmployee,
          currentEmployee: currentEmlpoyee));
    });
    on<EmployeeNameChangedEvent>((event, emit) {
      emit(state.copyWith(employeeName: event.employeeName));
    });

    on<EmployeeRoleChangedEvent>((event, emit) {
      emit(state.copyWith(employeeRole: event.employeeRole));
    });

    on<StartDateChangedEvent>((event, emit) {
      emit(state.copyWith(startDate: event.startDate));
    });

    on<EndDateChangedEvent>((event, emit) {
      emit(state.copyWith(endDate: event.endDate));
    });

    on<SaveEmployeeData>((event, emit) async {
      if (event.employeeId.isEmpty) {
        final newEmployee = Employee()
          ..employeeName = state.employeeName
          ..employeeRole = state.employeeRole
          ..startDate = state.startDate
          ..endDate = state.endDate
          ..isCurrentEmployee = state.endDate.isEmpty;
        await isar.writeTxn(() async {
          await isar.employees.put(newEmployee);
        });
      } else {
        final newEmployee = Employee()
          ..employeeName = state.employeeName
          ..employeeRole = state.employeeRole
          ..startDate = state.startDate
          ..endDate = state.endDate
          ..isCurrentEmployee = state.endDate.isEmpty
          ..id = int.parse(event.employeeId);
        await isar.writeTxn(() async {
          await isar.employees.put(newEmployee);
        });
      }
      add(ClearEmployeeData());
      add(HomePageOnstart());
    });

    on<DeleteEmployeeData>((event, emit) async {
      final employee = await isar.employees.get(int.parse(event.employeeId));
      await isar.writeTxn(() async {
        await isar.employees.delete(int.parse(event.employeeId));
      });
      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(SnackBar(
          content: const Text('Employee data has been deleted'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () async {
                await isar.writeTxn(() async {
                  await isar.employees.put(employee!);
                });
                add(HomePageOnstart());
              }),
        ));
      }
      add(HomePageOnstart());
    });

    on<ClearEmployeeData>((event, emit) {
      emit(state.copyWith(
        employeeName: '',
        employeeRole: '',
        endDate: '',
        startDate: '',
      ));
    });
  }
}
