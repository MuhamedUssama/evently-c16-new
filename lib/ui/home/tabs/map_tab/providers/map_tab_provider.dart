import 'dart:async';
import 'dart:developer';

import 'package:evently_c16/core/source/remote/FirestoreManager.dart';
import 'package:evently_c16/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTabProvider extends ChangeNotifier {
  MapTabProvider() {
    log('Get Location in constructor');
    getUserLocation();
    getAllEvents();
  }

  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );

  Set<Marker> markers = {};

  final Location location = Location();
  late final StreamSubscription<LocationData> _locationStream;

  final List<Event> events = [];
  Future<void> getAllEvents() async {
    List<Event> firestoreEvents = await FirestoreManager.getAllEvents();
    events.addAll(firestoreEvents);
    notifyListeners();
  }

  void getEventLocationOnMap(Event event) {
    cameraPosition = CameraPosition(
      target: LatLng(event.latitude ?? 0, event.longitude ?? 0),
      zoom: 17,
    );
    markers.add(
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position: LatLng(event.latitude ?? 0, event.longitude ?? 0),
        infoWindow: InfoWindow(
          title: event.title,
          snippet: '${event.city}, ${event.country}',
        ),
      ),
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  void changeCameraPositionOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );

    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: const InfoWindow(
          title: 'My Location',
          snippet: 'This is marker 1',
        ),
      ),
    );

    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 500);

    _locationStream = location.onLocationChanged.listen((
      LocationData currentLocation,
    ) {
      changeCameraPositionOnMap(currentLocation);
      notifyListeners();
    });
  }

  Future<void> getUserLocation() async {
    bool isPermissionGranted = await _getLocationPermission();
    if (!isPermissionGranted) return;

    bool isGpsServiceEnabled = await _checkLocationService();
    if (!isGpsServiceEnabled) return;

    LocationData locationData = await location.getLocation();

    changeCameraPositionOnMap(locationData);
    notifyListeners();
  }

  @override
  void dispose() {
    mapController.dispose();
    _locationStream.cancel();
    log('Provider disposed');
    super.dispose();
  }
}
