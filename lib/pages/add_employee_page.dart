import 'package:employeeapp/blocs/home/home_bloc.dart';
import 'package:employeeapp/constants/color_constants.dart';
import 'package:employeeapp/constants/image_constants.dart';
import 'package:employeeapp/models/employee.dart';
import 'package:employeeapp/services/service_locator.dart';
import 'package:employeeapp/widgets/custom_textfield.dart';
import 'package:employeeapp/widgets/custom_date_picker_dialog.dart';
import 'package:employeeapp/widgets/role_selection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key, this.isEdit = false, this.employee});

  final bool isEdit;
  final Employee? employee;

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final employeeNameTextController = TextEditingController();

  final employeeRoleTextController = TextEditingController();

  final startDateTextController = TextEditingController();

  final endDateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setEditValues();
  }

  void setEditValues() {
    setState(() {
      if (widget.isEdit) {
        employeeNameTextController.text = widget.employee?.employeeName ?? '';
        employeeRoleTextController.text = widget.employee?.employeeRole ?? '';
        startDateTextController.text =
            getSimplifiedDate(widget.employee?.startDate ?? '');
        endDateTextController.text =
            getSimplifiedDate(widget.employee?.endDate ?? '');

        serviceLocator.get<HomeBloc>().add(EmployeeNameChangedEvent(
            employeeName: widget.employee?.employeeName ?? ''));
        serviceLocator.get<HomeBloc>().add(EmployeeRoleChangedEvent(
            employeeRole: widget.employee?.employeeRole ?? ''));
        serviceLocator.get<HomeBloc>().add(
            StartDateChangedEvent(startDate: widget.employee?.startDate ?? ''));
        serviceLocator
            .get<HomeBloc>()
            .add(EndDateChangedEvent(endDate: widget.employee?.endDate ?? ''));
      }
    });
  }

  getSimplifiedDate(String dateTime) {
    if (dateTime.isEmpty) {
      return '';
    }
    return DateFormat('d MMM y').format(DateTime.parse(dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.employeeRole != employeeRoleTextController.text) {
          employeeRoleTextController.text = state.employeeRole;
        }
        if (getSimplifiedDate(state.startDate) !=
            startDateTextController.text) {
          startDateTextController.text = getSimplifiedDate(state.startDate);
        }
        if (getSimplifiedDate(state.endDate) != endDateTextController.text) {
          endDateTextController.text = getSimplifiedDate(state.endDate);
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            serviceLocator.get<HomeBloc>().add(ClearEmployeeData());
            return Future.value(true);
          },
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.blue,
                automaticallyImplyLeading: false,
                title: Text('Add Employee Details',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18.sp)),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(20.sp, 24.sp, 20.sp, 20.sp),
                      children: [
                        CustomTextField(
                          key: const Key('name-key'),
                          borderRadius: 4.sp,
                          textEditingController: employeeNameTextController,
                          hintText: 'Employee Name',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.0.sp),
                            child: SvgPicture.asset(
                              ImageConstants.person,
                              height: 20.sp,
                            ),
                          ),
                          onChanged: (value) {
                            serviceLocator.get<HomeBloc>().add(
                                EmployeeNameChangedEvent(employeeName: value));
                          },
                        ),
                        SizedBox(
                          height: 23.sp,
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.sp),
                                  topRight: Radius.circular(20.sp),
                                ),
                              ),
                              isScrollControlled: false,
                              builder: (context) {
                                return const RoleSelectionBottomSheet();
                              },
                            );
                          },
                          child: CustomTextField(
                            key: const Key('role-key'),
                            borderRadius: 4.sp,
                            hintText: 'Select Role',
                            isEnabled: false,
                            textEditingController: employeeRoleTextController,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.blue,
                              size: 30.sp,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(14.0.sp),
                              child: SvgPicture.asset(
                                ImageConstants.work,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 23.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const CustomDatePickerDialog(
                                        isStartDate: true,
                                      );
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  key: const Key('start-key'),
                                  isEnabled: false,
                                  borderRadius: 4.sp,
                                  hintText: 'No Date',
                                  textEditingController:
                                      startDateTextController,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(14.0.sp),
                                    child: SvgPicture.asset(
                                      ImageConstants.event,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sp),
                              child: Icon(
                                Icons.arrow_right_alt_outlined,
                                color: Colors.blue,
                                size: 20.sp,
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const CustomDatePickerDialog();
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  key: const Key('end-key'),
                                  isEnabled: false,
                                  borderRadius: 4.sp,
                                  hintText: 'No Date',
                                  textEditingController: endDateTextController,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(14.0.sp),
                                    child: SvgPicture.asset(
                                      ImageConstants.event,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1.sp,
                    color: ColorConstants.textfieldBorderColor,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            serviceLocator
                                .get<HomeBloc>()
                                .add(ClearEmployeeData());
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 73.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.sp),
                              color: Colors.blue.withOpacity(0.1),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.blue, fontSize: 14.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.sp,
                        ),
                        InkWell(
                          onTap: () {
                            if (state.employeeName.isNotEmpty &&
                                state.employeeRole.isNotEmpty &&
                                state.startDate.isNotEmpty) {
                              serviceLocator.get<HomeBloc>().add(
                                  SaveEmployeeData(
                                      employeeId: widget.isEdit
                                          ? (widget.employee?.id ?? 0)
                                              .toString()
                                          : ''));
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please fill all the details')));
                            }
                          },
                          child: Container(
                            width: 73.sp,
                            height: 40.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Save',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.white, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
