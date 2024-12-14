import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/base/utils/urls.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/core/shared_widgets/profile_tile.dart';
import 'package:school_app/features/admin/student/controller/student_controller.dart';

class PaymentSelection extends StatefulWidget {
  const PaymentSelection({super.key});

  @override
  State<PaymentSelection> createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  @override
  void initState() {
    context.read<StudentController>().getStudentsByParentEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Responsive.height * 1,
          ),
          CustomAppbar(
            title: 'Payments',
            isBackButton: false,
          ),
          SizedBox(
            height: Responsive.height * 1,
          ),
          Consumer<StudentController>(builder: (context, value, child) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.studentsByParents.length,
              itemBuilder: (context, index) {
                final student = value.studentsByParents[index];
                return value.isloading
                    ? Loading(
                        color: Colors.grey,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ProfileTile(
                          name: capitalizeEachWord(student.fullName ?? ""),
                          description: student.studentClass ?? "",
                          imageUrl:
                              "${baseUrl}${Urls.studentPhotos}${student.studentPhoto}",
                          onPressed: () {
                            context.pushNamed(
                                AppRouteConst.ParentPaymentScreenRouteName,
                                extra: student.id);
                          },
                        ),
                      );
              },
            );
          }),
        ],
      ),
    );
  }
}
