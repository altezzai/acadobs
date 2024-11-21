import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/navbar/screen/bottom_nav.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/payments/model/payment_model.dart';

class PaymentView extends StatefulWidget {
  final Payment payment;

  PaymentView({required this.payment});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  // Helper method to get color based on status
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.grey; // Default for unknown status
    }
  }

  // Helper method to get icon based on status
  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle;
      case 'Pending':
        return Icons.hourglass_empty;
      case 'Failed':
        return Icons.cancel;
      default:
        return Icons.help_outline; // Default for unknown status
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppbar(
              title: "Payments",
              isProfileIcon: false,
              onTap: () {
                context.goNamed(
                  AppRouteConst.bottomNavRouteName,
                  extra: UserType.admin,
                );
              },
            ),
            SizedBox(height: Responsive.height * 2),
            CircleAvatar(
              backgroundImage: widget.payment.studentPhoto != null
                  ? NetworkImage(widget.payment.studentPhoto)
                  : AssetImage('assets/child1.png') as ImageProvider,
              radius: 25,
            ),
            SizedBox(height: Responsive.height * 2),
            Text(
              'From ${capitalizeFirstLetter(widget.payment.fullName ?? "")}',
              style: textThemeData.bodyMedium,
            ),
            Text(widget.payment.transactionId ?? ""),
            SizedBox(height: Responsive.height * 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _getStatusColor(widget.payment.paymentStatus)
                    .withOpacity(0.2),
              ),
              child: Text(
                '₹${widget.payment.amountPaid}',
                style: TextStyle(
                  fontSize: 55,
                  color: _getStatusColor(widget.payment.paymentStatus),
                ),
              ),
            ),
            SizedBox(height: Responsive.height * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getStatusIcon(widget.payment.paymentStatus),
                  color: _getStatusColor(widget.payment.paymentStatus),
                  size: 30,
                ),
                SizedBox(width: Responsive.width * 2),
                Text(
                  widget.payment.paymentStatus ?? "Unknown Status",
                  style: TextStyle(
                    fontSize: 16,
                    color: _getStatusColor(widget.payment.paymentStatus),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height * 1),
            Container(
              height: Responsive.height * .1,
              width: Responsive.width * 60,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: Responsive.height * 2),
            Text(
              '${DateFormatter.formatDateString(widget.payment.paymentDate.toString())}, ${TimeFormatter.formatTimeFromString(widget.payment.createdAt.toString())}',
            ),
          ],
        ),
      ),
    );
  }
}
