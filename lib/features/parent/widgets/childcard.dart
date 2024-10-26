import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';

class ChildCard extends StatelessWidget {
  final String childName;
  final String className;
  final ImageProvider imageProvider;

  const ChildCard({
    super.key,
    required this.childName,
    required this.className,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: imageProvider,
        ),
        title: Text(childName),
        subtitle: Text(className),
        trailing: TextButton(
          onPressed: () {
            context.pushReplacementNamed(
              AppRouteConst.ParentStudentDetailRouteName,
              extra: {
                'name': childName,
                'studentClass': className,
                'image': imageProvider,
              },
            );
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ParentStudentDetailPage(
            //               name: childName,
            //               studentClass: className,
            //               image: imageProvider,
            //             )));
          },
          child: const Text("View"),
        ),
      ),
    );
  }
}
