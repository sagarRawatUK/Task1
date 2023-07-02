import 'package:employeeapp/blocs/home/home_bloc.dart';
import 'package:employeeapp/constants/image_constants.dart';
import 'package:employeeapp/pages/add_employee_page.dart';
import 'package:employeeapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    serviceLocator.get<HomeBloc>().add(InitIsar());
    super.initState();
  }

  getSimplifiedDate(String dateTime) {
    if (dateTime.isEmpty) {
      return '';
    }
    return DateFormat('d MMM y').format(DateTime.parse(dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            title: Text(
              'Employee List',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 18.sp),
            ),
          ),
          floatingActionButton: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEmployeePage()));
            },
            child: Container(
              height: 50.sp,
              width: 50.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              child: Icon(
                Icons.add,
                size: 28.sp,
                color: Colors.white,
              ),
            ),
          ),
          body: (state.currentEmployee.isEmpty &&
                  state.previousEmployee.isEmpty)
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(83.0.sp),
                    child: Image.asset(
                      ImageConstants.notData,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          if (state.currentEmployee.isNotEmpty)
                            Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.sp),
                                  width: double.infinity,
                                  height: 56.sp,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text('Current Employee',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Colors.blue,
                                                    fontSize: 16.sp)),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEmployeePage(
                                                        isEdit: true,
                                                        employee: state
                                                                .currentEmployee[
                                                            index],
                                                      )));
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          child: Dismissible(
                                              onDismissed: (direction) {
                                                serviceLocator
                                                    .get<HomeBloc>()
                                                    .add(DeleteEmployeeData(
                                                        employeeId:
                                                            '${state.currentEmployee[index].id}'));
                                              },
                                              background: Container(
                                                alignment: Alignment.centerLeft,
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(15.sp),
                                                  child: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              secondaryBackground: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(15.sp),
                                                  child: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              key: Key(
                                                  '${state.currentEmployee[index].id}'),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.sp,
                                                    vertical: 16.sp),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      state
                                                              .currentEmployee[
                                                                  index]
                                                              .employeeName ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    SizedBox(
                                                      height: 4.sp,
                                                    ),
                                                    Text(
                                                      state
                                                              .currentEmployee[
                                                                  index]
                                                              .employeeRole ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 14.sp,
                                                              color: Colors
                                                                  .black38,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                    SizedBox(
                                                      height: 4.sp,
                                                    ),
                                                    Text(
                                                      'From ${getSimplifiedDate(state.currentEmployee[index].startDate ?? '')}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 12.sp,
                                                              color: Colors
                                                                  .black38,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        height: 1.sp,
                                      );
                                    },
                                    itemCount: state.currentEmployee.length)
                              ],
                            ),
                          if (state.previousEmployee.isNotEmpty)
                            Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.sp),
                                  width: double.infinity,
                                  height: 56.sp,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text('Previous Employee',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 16.sp,
                                                    color: Colors.blue)),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddEmployeePage(
                                                        isEdit: true,
                                                        employee: state
                                                                .previousEmployee[
                                                            index],
                                                      )));
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          child: Dismissible(
                                              onDismissed: (direction) {
                                                serviceLocator
                                                    .get<HomeBloc>()
                                                    .add(DeleteEmployeeData(
                                                        employeeId:
                                                            '${state.previousEmployee[index].id}'));
                                              },
                                              background: Container(
                                                alignment: Alignment.centerLeft,
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(15.sp),
                                                  child: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              secondaryBackground: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(15.sp),
                                                  child: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              key: Key(
                                                  '${state.previousEmployee[index].id}'),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.sp,
                                                    vertical: 16.sp),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      state
                                                              .previousEmployee[
                                                                  index]
                                                              .employeeName ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    SizedBox(
                                                      height: 4.sp,
                                                    ),
                                                    Text(
                                                      state
                                                              .previousEmployee[
                                                                  index]
                                                              .employeeRole ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 14.sp,
                                                              color: Colors
                                                                  .black38,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                    SizedBox(
                                                      height: 4.sp,
                                                    ),
                                                    Text(
                                                      '${getSimplifiedDate(state.previousEmployee[index].startDate ?? '')} - ${getSimplifiedDate(state.previousEmployee[index].endDate ?? '')}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 12.sp,
                                                              color: Colors
                                                                  .black38,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        height: 1.sp,
                                      );
                                    },
                                    itemCount: state.previousEmployee.length)
                              ],
                            ),
                        ],
                      ),
                    ),
                    if (state.currentEmployee.isNotEmpty &&
                        state.previousEmployee.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        width: double.infinity,
                        height: 56.sp,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('Swipe left to delete',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 15.sp,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
