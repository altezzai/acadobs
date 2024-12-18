import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/capitalize_first_letter.dart';
import 'package:school_app/base/utils/constants.dart';
import 'package:school_app/base/utils/date_formatter.dart';
import 'package:school_app/base/utils/responsive.dart';
import 'package:school_app/base/utils/show_loading.dart';
import 'package:school_app/core/shared_widgets/add_button.dart';
import 'package:school_app/core/shared_widgets/custom_appbar.dart';
import 'package:school_app/features/admin/payments/controller/payment_controller.dart';
import 'package:school_app/features/admin/payments/widgets/payment_item.dart';

class PaymentsHomeScreen extends StatefulWidget {
  @override
  _PaymentsHomeScreenState createState() => _PaymentsHomeScreenState();
}

class _PaymentsHomeScreenState extends State<PaymentsHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return LayoutBuilder(
      builder: (context, constraints) {
        Orientation orientation = MediaQuery.of(context).orientation;
        Responsive().init(constraints, orientation);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
         SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: Responsive.height * 2),
                CustomAppbar(
                  title: "Payments",
                  isBackButton: false,
                ),
                 SizedBox(
                            height: Responsive.height * 2),
                Row(
                  children: [
                    Expanded(
                      child: AddButton(
                        iconPath: paymentIcon,
                        onPressed: () {
                          context.pushNamed(AppRouteConst.AddPaymentRouteName);
                        },
                        text: "Add Payment",
                      ),
                    ),
                     SizedBox(                                width: Responsive.width * 4), // 16px equivalent
                    Expanded(
                      child: AddButton(
                        iconPath: donationIcon,
                        onPressed: () {
                          context.pushNamed(AppRouteConst.AddDonationRouteName);
                        },
                        text: "Add Donation",
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 20),
         
                ]))),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: TabBar(
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: Responsive.width * 4),
                        dividerHeight: 3,
                        indicatorWeight: 3,
                        dividerColor: Colors.grey,
                        // indicatorPadding: EdgeInsets.symmetric(horizontal: 1),
                        tabAlignment: TabAlignment.center,
                        indicatorColor: Colors.black,
                        unselectedLabelColor: Color(0xFF757575),
                        unselectedLabelStyle: TextStyle(fontSize: 14),
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                        labelStyle: textThemeData.bodyMedium?.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: 'Payments'),
                          Tab(text: 'Donations'),
                        ],
                      ),
                    ),
                  ),
                ),];
                },
                body: Padding(
              padding: EdgeInsets.only(top: Responsive.height * 14),
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: _buildPaymentsList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildDonationsList(),
                  ),
                ],
              ),
            ),
      ),
    );
      });
  }

  /// Reusable function to group items by date.
  Map<String, List<T>> groupItemsByDate<T>(
    List<T> items,
    DateTime Function(T) getDate, // Function to extract the date from the item
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    Map<String, List<T>> groupedItems = {};

    for (var item in items) {
      final itemDate = getDate(item);
      String formattedDate;
      if (itemDate.isAtSameMomentAs(today)) {
        formattedDate = "Today";
      } else if (itemDate.isAtSameMomentAs(yesterday)) {
        formattedDate = "Yesterday";
      } else {
        formattedDate = DateFormat.yMMMMd().format(itemDate);
      }

      if (!groupedItems.containsKey(formattedDate)) {
        groupedItems[formattedDate] = [];
      }
      groupedItems[formattedDate]!.add(item);
    }

    // Sort grouped dates with "Today" and "Yesterday" on top, followed by descending dates.
    List<MapEntry<String, List<T>>> sortedEntries = [];
    if (groupedItems.containsKey("Today")) {
      sortedEntries.add(MapEntry("Today", groupedItems["Today"]!));
      groupedItems.remove("Today");
    }
    if (groupedItems.containsKey("Yesterday")) {
      sortedEntries.add(MapEntry("Yesterday", groupedItems["Yesterday"]!));
      groupedItems.remove("Yesterday");
    }

    sortedEntries.addAll(
      groupedItems.entries.toList()
        ..sort((a, b) {
          final dateA = DateFormat.yMMMMd().parse(a.key, true);
          final dateB = DateFormat.yMMMMd().parse(b.key, true);
          return dateB.compareTo(dateA); // Sort descending by date
        }),
    );

    return Map.fromEntries(sortedEntries);
  }

  Widget _buildPaymentsList() {
    context.read<PaymentController>().getPayments();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
       return Loading(
          color: Colors.grey,
        );
      }

      final groupedPayments = groupItemsByDate(
        value.payments,
        (payment) =>
            DateTime.tryParse(payment.paymentDate.toString()) ?? DateTime.now(),
      );

      return _buildGroupedList(groupedPayments, (payment, index, total) {
        final isFirst = index == 0;
        final isLast = index == total - 1;
        final topRadius = isFirst ? 16 : 0;
        final bottomRadius = isLast ? 16 : 0;

      return  Padding(
        padding: const EdgeInsets.only(bottom: 1.5),
        child:value.payments.isEmpty ? Center(child: Text("No Payments Found!"),) : PaymentItem(
                      bottomRadius: bottomRadius.toDouble(),
            topRadius: topRadius.toDouble(),
                      amount: payment.amountPaid ?? "",
                      name: capitalizeFirstLetter(payment.fullName ?? ""),
                      time: TimeFormatter.formatTimeFromString(
                          payment.createdAt.toString()),
                      status: payment.paymentStatus ?? "",
                      onTap: () {
                        context.pushNamed(
                          AppRouteConst.PaymentViewRouteName,
                          extra: payment,
                        );
                      },
                    )
                  
                 );
      });
    });
  }

  Widget _buildDonationsList() {
    context.read<PaymentController>().getDonations();
    return Consumer<PaymentController>(builder: (context, value, child) {
      if (value.isloading) {
        return 
            Loading(
              color: Colors.grey,
            
          
        );
      }

      final groupedDonations = groupItemsByDate(
        value.donations,
        (donation) =>
            DateTime.tryParse(donation.donationDate.toString()) ??
            DateTime.now(),
      );
        return _buildGroupedList(groupedDonations, (donation, index, total) {
        final isFirst = index == 0;
        final isLast = index == total - 1;
        final topRadius = isFirst ? 16 : 0;
        final bottomRadius = isLast ? 16 : 0;

      return 
       Padding(
        padding: const EdgeInsets.only(bottom: 1.5),
         child:value.donations.isEmpty ? Center(child: Text("No Donations Found!"),) :  PaymentItem(
          bottomRadius: bottomRadius.toDouble(),
              topRadius: topRadius.toDouble(),
                        amount: donation.amountDonated ?? "",
                        name: capitalizeFirstLetter(donation.fullName ?? ""),
                        time: TimeFormatter.formatTimeFromString(
                            donation.createdAt.toString()),
                        status: donation.purpose ?? "",
                        onTap: () {
                          context.pushNamed(
                            AppRouteConst.DonationViewRouteName,
                            extra: donation,
                          );
                        },
                    
                   ),
       );
      });
    });
  }

 
  Widget _buildGroupedList<T>(Map<String, List<T>> groupedItems,
      Widget Function(T, int, int) buildItem) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedItems.entries.map((entry) {
          final itemCount = entry.value.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(entry.key),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return buildItem(entry.value[index], index, itemCount);
                },
              ),
              // SizedBox(
              //   height: Responsive.height * 2,
              // )
            ],
          );
        }).toList(),
      ),
    );
  }
   Widget _buildDateHeader(String date) {
    return Padding(
      padding: EdgeInsets.only(
        top: Responsive.height * 2, // 20px equivalent
        bottom: Responsive.height * 1, // 10px equivalent
      ),
      child: Text(
        date,
        style: textThemeData.bodyMedium?.copyWith(
          fontSize: 16, // Responsive font size
        ),
      ),
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isAtSameMomentAs(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}


// ******************Payment in report page***************************
  // Widget _buildClassDivisionPayment({required BuildContext context}) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Expanded(
  //             child: CustomDropdown(
  //               dropdownKey: 'class',
  //               label: 'Class',
  //               items: ['8', '9', '10'],
  //               icon: Icons.school,
  //               onChanged: (selectedClass) {
  //                 final selectedDivision = context
  //                     .read<DropdownProvider>()
  //                     .getSelectedItem('division');
  //                 context
  //                     .read<PaymentController>()
  //                     .getPaymentsByClassAndDivision(
  //                       className: selectedClass,
  //                       section: selectedDivision,
  //                     );
  //               },
  //             ),
  //           ),
  //           const SizedBox(width: 5),
  //           Expanded(
  //             child: CustomDropdown(
  //               dropdownKey: 'division',
  //               label: 'Division',
  //               items: ['A', 'B', 'C'],
  //               icon: Icons.group,
  //               onChanged: (selectedDivision) {
  //                 final selectedClass =
  //                     context.read<DropdownProvider>().getSelectedItem('class');
  //                 context
  //                     .read<PaymentController>()
  //                     .getPaymentsByClassAndDivision(
  //                       className: selectedClass,
  //                       section: selectedDivision,
  //                     );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 10),
  //       Expanded(
  //         child: Consumer<PaymentController>(
  //           builder: (context, value, child) {
              
  //             return ListView.builder(
  //               padding: EdgeInsets.zero,
  //               itemCount: value.payments.length,
  //               itemBuilder: (context, index) {
  //                 final payment = value.payments[index];
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 4),
  //                   child: PaymentItem(
  //                     amount: payment.amountPaid ?? "",
  //                     name: payment.fullName ?? "",
  //                     time: TimeFormatter.formatTimeFromString(
  //                         payment.createdAt.toString()),
  //                     status: payment.paymentStatus ?? "",
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
  // ******************End of Payment in report page***************************//