import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/ui/create_event/provider/create_event_provider.dart';
import 'package:flutter/material.dart';

class ChooseEventLocation extends StatelessWidget {
  final CreateEventProvider provider;
  const ChooseEventLocation({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          RoutesManager.pickLocationScreen,
          arguments: provider,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.gps_fixed,
                  color: ColorsManager.lightBackgroundColor,
                ),
              ),
              Text(
                provider.eventLocation == null
                    ? 'Choose Event Location'
                    : '${provider.city}, ${provider.country}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: ColorsManager.primaryColor,
          ),
        ],
      ),
    );
  }
}
