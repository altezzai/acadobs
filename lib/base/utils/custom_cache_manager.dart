import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomImageCacheManager {
  static final BaseCacheManager instance = CacheManager(
    Config(
      'customImageCacheKey', // Custom key
      stalePeriod: const Duration(days: 7), // Cached for 7 days
      maxNrOfCacheObjects: 100,
    ),
  );
}
