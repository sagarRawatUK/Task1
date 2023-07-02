import 'package:employeeapp/blocs/home/home_bloc.dart';
import 'package:employeeapp/constants/color_constants.dart';
import 'package:employeeapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleSelectionBottomSheet extends StatelessWidget {
  const RoleSelectionBottomSheet({super.key});

  final roleList = const [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: roleList.length,
          separatorBuilder: (context, index) => const Divider(
            height: 25,
            color: ColorConstants.textfieldBorderColor,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                serviceLocator.get<HomeBloc>().add(
                    EmployeeRoleChangedEvent(employeeRole: roleList[index]));
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  roleList[index],
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
