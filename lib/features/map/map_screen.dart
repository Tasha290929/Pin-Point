import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_point/features/map/data/mock/mock_locations.dart';
import 'package:pin_point/features/map/mappers/location_marker_mapper.dart';
import 'package:pin_point/features/map/widgets/location_detail_screen.dart';
import 'package:pin_point/features/map/widgets/location_preview_card.dart';

import 'data/models/model_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation = const LatLng(47.0226169258875, 28.83370399229604);
  late GoogleMapController googleMapController;
  Set<Marker> marker = {};
  ModelLocation? selectedLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _loadMockMarkers();
  }

  Future<void> _loadMockMarkers() async {
    final loadedMarkers = await LocationMarkerMapper.toMarkerSet(
      MockLocations.all,
      onTap: _onMarkerTap,
    );

    setState(() {
      marker = loadedMarkers;
    });
  }

  void _onMarkerTap(ModelLocation locations) {
    setState(() {
      selectedLocation = locations;
    });
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            markers: marker,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 11,
            ),
          ),
          if (selectedLocation != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: LocationPreviewCard(
                  location: selectedLocation!,
                  onClose: () => setState(() => selectedLocation = null),
                  onDetails: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) =>
                          LocationDetailScreen(location: selectedLocation!),
                    );
                  },
                  onNavigate: onNavigate,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          Position position = await currentPosition();
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 12,
                target: LatLng(position.latitude, position.longitude),
              ),
            ),
          );
          marker.add(
            Marker(
              markerId: MarkerId("My location"),
              position: LatLng(position.latitude, position.longitude),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.my_location, size: 16),
      ),
    );
  }

  Future<Position> currentPosition() async {
    bool serviceEnable;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location denied permanently");
    }

    //check if location service are enable
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location service are disable");
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  void onNavigate() {}
}
