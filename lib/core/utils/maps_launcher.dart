import 'package:florista_ecommerce_app/core/constants/static_delivery_address.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class MapsLauncher {
  static Future<bool> openDeliveryAddress() {
    return openCoordinates(
      latitude: StaticDeliveryAddress.latitude,
      longitude: StaticDeliveryAddress.longitude,
      label: StaticDeliveryAddress.mapsSearchQuery,
    );
  }

  static Future<bool> openCoordinates({
    required double latitude,
    required double longitude,
    String? label,
  }) async {
    final query = label ?? StaticDeliveryAddress.mapsSearchQuery;
    final encodedQuery = Uri.encodeComponent(query);
    final encodedLabel = Uri.encodeComponent('$latitude,$longitude ($query)');

    final candidates = <Uri>[
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS)
        Uri.parse(
          'http://maps.apple.com/?ll=$latitude,$longitude&q=$encodedQuery',
        ),
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
        Uri.parse('geo:$latitude,$longitude?q=$encodedLabel'),
      Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
      ),
      Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encodedQuery',
      ),
    ];

    for (final uri in candidates) {
      try {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (launched) return true;
      } on Exception {
        continue;
      }
    }

    return false;
  }
}
