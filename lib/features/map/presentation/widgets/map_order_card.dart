import 'package:florista_ecommerce_app/core/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:florista_ecommerce_app/features/map/presentation/view_model/map_event.dart';
import 'package:florista_ecommerce_app/features/map/presentation/view_model/map_view_model.dart';

class MapOrderCard extends StatelessWidget {
  const MapOrderCard({
    super.key,
    required this.image,
    required this.name,
    required this.address,
    required this.phone,
  });
  final String image;
  final String name;
  final String address;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 20);
                  },
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(
                width: ScreenSize.w(context, 50),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 16),
                  SizedBox(
                    width: ScreenSize.w(context, 65),
                    child: Text(
                      address,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),

          IconButton(
            onPressed: () =>
                context.read<MapCubit>().onEvent(CallUserEvent(phone: phone)),
            icon: Icon(
              Icons.phone_outlined,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
