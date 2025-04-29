import 'package:flutter/material.dart';
import 'package:school_app/base/utils/pagination_loading.dart';
import 'package:school_app/core/shared_widgets/common_appbar.dart';
import 'package:school_app/core/shared_widgets/custom_container.dart';

class GenericListScreen<T> extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onAddTap;
  final bool isLoading;
  final bool isLoadingMore;
  final List<T> items;
  final ScrollController scrollController;
  final Widget Function(T item) itemBuilder;

  const GenericListScreen({
    super.key,
    required this.title,
    this.buttonText = 'Item',
    required this.onAddTap,
    required this.isLoading,
    required this.isLoadingMore,
    required this.items,
    required this.scrollController,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CustomContainer(
              color: Colors.black,
              isCenterText: true,
              text: 'Add $buttonText',
              icon: Icons.add,
              ontap: onAddTap,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading && items.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: items.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < items.length) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: itemBuilder(items[index]),
                          );
                        } else {
                          return PaginationLoading();
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
