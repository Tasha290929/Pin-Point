import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pin_point/features/map/data/mock/mock_locations.dart';
import 'package:pin_point/features/map/mappers/location_marker_mapper.dart';
import 'package:pin_point/features/map/widgets/location_detail_screen.dart';
import 'package:pin_point/features/map/widgets/location_preview_card.dart';
import 'package:pin_point/features/profile/profile_screen.dart';

import '../../core/theme/app_theme.dart';
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
  final GlobalKey _previewCardKey = GlobalKey();
  double _previewCardHeight = 0;

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _measurePreviewCard());
  }

  void _measurePreviewCard() {
    final box =
        _previewCardKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize && box.size.height != _previewCardHeight) {
      setState(() => _previewCardHeight = box.size.height);
    }
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
          Positioned(
            top: 0,
            right: 16,
            child: SafeArea(
              child: FloatingActionButton(
                heroTag: 'profileButton',
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.person_outline,
                  size: 24,
                  color: AppTheme.accentColor,
                ),
              ),
            ),
          ),
          if (selectedLocation != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: KeyedSubtree(
                  key: _previewCardKey,
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
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            right: 16,
            bottom: selectedLocation != null
                ? _previewCardHeight +
                      MediaQuery.of(context).padding.bottom +
                      24
                : 16 + MediaQuery.of(context).padding.bottom,
            child: FloatingActionButton(
              heroTag: 'myLocationButton',
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              onPressed: () async {
                try {
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
                } catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(_locationErrorMessage(e))),
                  );
                }
              },
              child: const Icon(
                Icons.my_location,
                size: 24,
                color: AppTheme.accentColor,
              ),
            ),
          ),
        ],
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

  String _locationErrorMessage(Object error) {
    switch (error.toString()) {
      case "location permission denied":
        return "Location permission denied. Please allow access to use this feature.";
      case "Location denied permanently":
        return "Location access is permanently denied. Enable it in app settings.";
      case "Location service are disable":
        return "Location services are turned off. Please enable them.";
      default:
        return "Could not get your location. Please try again.";
    }
  }

  void onNavigate() {}
}
