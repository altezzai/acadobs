import 'package:flutter/material.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/payments/model/donation_model.dart';

class DonationView extends StatefulWidget {
  final Donation donation;
  DonationView({required this.donation});

  @override
  State<DonationView> createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomAppbar(
              title: 'Donations',
              isProfileIcon: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: Responsive.height * 2),
            CircleAvatar(
              backgroundImage: widget.donation.studentPhoto != null
                  ? NetworkImage(widget.donation.studentPhoto)
                  : AssetImage('assets/child1.png') as ImageProvider,
              radius: 25,
            ),
            SizedBox(height: Responsive.height * 2),
            Text(
              'From ${capitalizeFirstLetter(widget.donation.fullName ?? "")}',
              style: textThemeData.bodyMedium,
            ),
            Text(widget.donation.transactionId ?? ""),
            SizedBox(height: Responsive.height * 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green.shade100.withOpacity(0.2),
              ),
              child: Text(
                '₹${widget.donation.amountDonated}',
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: Responsive.height * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(width: Responsive.width * 2),
                Text('Completed', style: textThemeData.bodyMedium),
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
              '${DateFormatter.formatDateString(widget.donation.donationDate.toString())}  ${TimeFormatter.formatTimeFromString(
                widget.donation.createdAt.toString(),
              )}',
            ),
          ],
        ),
      ),
    );
  }
}
