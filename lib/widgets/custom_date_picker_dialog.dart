import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:employeeapp/blocs/home/home_bloc.dart';
import 'package:employeeapp/constants/color_constants.dart';
import 'package:employeeapp/constants/image_constants.dart';
import 'package:employeeapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CustomDatePickerDialog extends StatefulWidget {
  const CustomDatePickerDialog({super.key, this.isStartDate = false});

  final bool isStartDate;

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  String selectedDate = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.sp),
          ),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24.sp,
                ),
                widget.isStartDate
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedDate =
                                            DateTime.now().toString();
                                      });
                                    },
                                    child: Container(
                                      height: 36.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blue.withOpacity(0.1),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Today',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.blue,
                                                fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.sp,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = DateTime.now()
                                            .add(Duration(
                                              days: (DateTime.monday -
                                                      DateTime.now().weekday) %
                                                  DateTime.daysPerWeek,
                                            ))
                                            .toString();
                                      });
                                    },
                                    child: Container(
                                      height: 36.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blue,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Next Monday',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = DateTime.now()
                                            .add(Duration(
                                              days: (DateTime.tuesday -
                                                      DateTime.now().weekday) %
                                                  DateTime.daysPerWeek,
                                            ))
                                            .toString();
                                      });
                                    },
                                    child: Container(
                                      height: 36.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blue.withOpacity(0.1),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Next Tuesday',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.blue,
                                                fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.sp,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = DateTime.now()
                                            .add(const Duration(days: 7))
                                            .toString();
                                      });
                                    },
                                    child: Container(
                                      height: 36.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blue.withOpacity(0.1),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'After 1 week',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.blue,
                                                fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedDate = '';
                                  });
                                },
                                child: Container(
                                  height: 36.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.blue,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'No Date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.sp,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedDate = DateTime.now().toString();
                                  });
                                },
                                child: Container(
                                  height: 36.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.blue.withOpacity(0.1),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Today',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.blue,
                                            fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Theme(
                    data: ThemeData(
                      colorScheme:
                          const ColorScheme.light(primary: Colors.blue),
                    ),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          centerAlignModePicker: true,
                          weekdayLabels: [
                            'Sun',
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thr',
                            'Fri',
                            'Sat'
                          ]),
                      value: widget.isStartDate
                          ? state.startDate.isNotEmpty
                              ? [DateTime.parse(state.startDate)]
                              : []
                          : state.endDate.isNotEmpty
                              ? [DateTime.parse(state.endDate)]
                              : [],
                      onValueChanged: (dates) {
                        setState(() {
                          selectedDate =
                              dates.isNotEmpty ? dates.first.toString() : '';
                        });
                      },
                    ),
                  ),
                ),
                Divider(
                  height: 1.sp,
                  color: ColorConstants.textfieldBorderColor,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstants.event,
                        height: 23.sp,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Text(
                        selectedDate.isNotEmpty
                            ? DateFormat('d MMM y')
                                .format(DateTime.parse(selectedDate))
                            : 'No Date',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black, fontSize: 14.sp),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
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
                                .copyWith(color: Colors.blue, fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.sp,
                      ),
                      InkWell(
                        onTap: () {
                          if (widget.isStartDate) {
                            serviceLocator.get<HomeBloc>().add(
                                StartDateChangedEvent(startDate: selectedDate));
                          } else {
                            serviceLocator.get<HomeBloc>().add(
                                EndDateChangedEvent(endDate: selectedDate));
                          }
                          Navigator.pop(context);
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
                                .copyWith(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
