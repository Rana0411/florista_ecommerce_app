import 'package:florista_ecommerce_app/config/shared_models/map_extra.dart';
import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:florista_ecommerce_app/features/map/presentation/widgets/map_order_container.dart';
import 'package:florista_ecommerce_app/features/map/presentation/widgets/order_map_widget.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.mapExtra});

  final MapExtra mapExtra;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late LatLng endLocation;

  @override
  void initState() {
    super.initState();

    final lat = double.tryParse(widget.mapExtra.shippingAddressEntity.lat) ?? 0;

    final long =
        double.tryParse(widget.mapExtra.shippingAddressEntity.long) ?? 0;

    endLocation = LatLng(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Location')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            SizedBox(
              height: ScreenSize.h(context, 50),
              child: OrderMapWidget(endLocation: endLocation),
            ),

            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 5,
              indent: 150,
              endIndent: 150,
              radius: BorderRadius.circular(10),
            ),

            MapOrderContainer(
              shippingAddressEntity: widget.mapExtra.shippingAddressEntity,

              userEntity: widget.mapExtra.userEntity,
            ),
          ],
        ),
      ),
    );
  }
}
