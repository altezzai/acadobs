import 'package:flutter/material.dart';

class LeaveRequestCard extends StatelessWidget {
  final String title;

  final String time;
  final String status;
  final void Function() onTap;
  final double bottomRadius;
  final double topRadius;

  const LeaveRequestCard(
      {required this.title,
      required this.time,
      required this.status,
      required this.onTap,
      this.bottomRadius = 10,
      this.topRadius = 10});

  static getStatusColor(String? status) {
    switch (status) {
      case 'Pending':
        return Color(0xFFA86637);
      case 'Approved':
        return Color(0xFF44A837);
      case 'Rejected':
        return Color(0xFFA83737);
      default:
        return Colors.grey;
    }
  }

  static getStatusIcon(String? status) {
    switch (status) {
      case 'Pending':
        return "assets/icons/pending_leave.png";
      case 'Approved':
        return "assets/icons/approved_leave.png";
      case 'Rejected':
        return "assets/icons/declined_leave.png";
      default:
        return "assets/icons/pending_leave.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomRadius),
              bottomRight: Radius.circular(bottomRadius),
              topLeft: Radius.circular(topRadius),
              topRight: Radius.circular(topRadius)),
        ),
        child: Row(
          children: [
            Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: getStatusColor(status).withOpacity(0.2),
                    // borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    getStatusIcon(status),
                    height: 22,
                    width: 20,
                  ),
                )),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: getStatusColor(status).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: getStatusColor(status),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Text(
                          time,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
