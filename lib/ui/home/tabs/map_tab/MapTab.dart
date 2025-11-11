import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/ui/home/tabs/map_tab/providers/map_tab_provider.dart';
import 'package:evently_c16/ui/home/tabs/map_tab/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    MapTabProvider provider = Provider.of<MapTabProvider>(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: provider.cameraPosition,
                  mapType: MapType.normal,
                  markers: provider.markers,
                  onMapCreated: (controller) {
                    provider.mapController = controller;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 124,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return EventCard(event: provider.events[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: provider.events.length,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.getUserLocation();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        backgroundColor: ColorsManager.primaryColor,
        foregroundColor: ColorsManager.lightBackgroundColor,
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
