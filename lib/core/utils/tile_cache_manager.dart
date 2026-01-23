import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

/// FMTC (Flutter Map Tile Caching) manager for offline map tiles
class TileCacheManager {
  static const String storeName = 'geosurvey_tiles';

  /// Initialize FMTC
  static Future<void> initialize() async {
    await FMTCObjectBoxBackend().initialise();

    // Create store if not exists
    final store = FMTCStore(storeName);
    await store.manage.create();
  }

  /// Get the tile store
  static FMTCStore getStore() {
    return FMTCStore(storeName);
  }

  /// Get tile provider for offline/online usage
  static FMTCTileProvider getTileProvider() {
    return FMTCTileProvider(stores: {storeName: BrowseStoreStrategy.read});
  }

  /// Get download statistics
  static Future<Map<String, dynamic>> getStats() async {
    final store = getStore();
    final stats = await store.stats.all;

    return {
      'tileCount': stats.length,
      'size': stats.size,
      'hits': stats.hits,
      'misses': stats.misses,
    };
  }

  /// Delete all cached tiles
  static Future<void> clearCache() async {
    final store = getStore();
    await store.manage.reset();
  }

  /// Delete store
  static Future<void> deleteStore() async {
    final store = getStore();
    await store.manage.delete();
  }
}
