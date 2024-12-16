import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/base/routes/app_route_const.dart';
import 'package:school_app/base/theme/text_theme.dart';
import 'package:school_app/base/utils/responsive.dart';

class EventCard extends StatelessWidget {
  final String eventTitle;
  final String eventDescription;
  final String date;
  final String time;
  final String imageProvider;
  final double bottomRadius;
  final double topRadius;

  const EventCard({
    super.key,
    required this.eventTitle,
    required this.eventDescription,
    required this.date,
    required this.time,
    required this.imageProvider,
    required this.bottomRadius,
    required this.topRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRouteConst.EventDetailedPageRouteName,
          extra: {
            'title': eventTitle,
            'description': eventDescription,
            'date': date,
            'imageProvider': imageProvider,
          },
        );
      },
      // child: Card(
      //   shape:
      //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //   child: ListTile(
      //     leading: ClipRRect(
      //       borderRadius: BorderRadius.circular(12.0),
      //       child: Image(
      //         image: imageProvider,
      //         height: 100,
      //         width: 100,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     title: Text(
      //       eventTitle,
      //       maxLines: 1, // Set max lines to 1 to keep it in a single line
      //       overflow: TextOverflow
      //           .ellipsis, // Show ellipsis (...) if the text overflows
      //       style: TextStyle(
      //         fontSize: MediaQuery.of(context).size.width *
      //             0.045, // Responsive font size
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     subtitle: Column(
      //       children: [
      //         Text(
      //           eventDescription,
      //           maxLines: 2, // Limit description to avoid overflow
      //           overflow:
      //               TextOverflow.ellipsis, // Handle overflow with ellipsis
      //           style: const TextStyle(
      //             fontSize: 14,
      //             color: Colors.grey,
      //           ),
      //         ),
      //         Align(
      //           alignment: Alignment.centerLeft,
      //           child: Container(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 8, vertical: 4),
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(8),
      //                   color: Colors.orange.withOpacity(0.1)),
      //               child: Text(date,
      //                   style: const TextStyle(color: Colors.orange))),
      //         ),
      //       ],
      //     ),
      //     trailing: Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(8),
      //             color: Colors.orange.withOpacity(0.1)),
      //         child:
      //             Text(time, style: const TextStyle(color: Colors.orange))),
      //     // trailing: Text(time),
      //   ),
      // )
      child: Container(
        padding: EdgeInsets.all(Responsive.height * 1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomRadius),
              bottomRight: Radius.circular(bottomRadius),
              topLeft: Radius.circular(topRadius),
              topRight: Radius.circular(topRadius)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.radius * 3),
              child: CachedNetworkImage(
                imageUrl: imageProvider,
                height: Responsive.height * 12,
                width: Responsive.height * 12,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.error,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(width: Responsive.width * 3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(eventTitle,
                      style: textThemeData.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                      // const TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 16,
                      // ),
                      ),
                  SizedBox(height: Responsive.height * .5),
                  Text(
                    eventDescription,
                    maxLines: 3, // Limit description to avoid overflow
                    overflow:
                        TextOverflow.ellipsis, // Handle overflow with ellipsis
                    style: textThemeData.bodySmall,
                    // const TextStyle(
                    //   fontSize: 14,
                    //   color: Colors.grey,
                    // ),
                  ),
                  SizedBox(height: Responsive.height * 1),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Spacer(),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.orange.withOpacity(0.1)),
                          child: Text(
                            time,
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 11),
                          )),
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
