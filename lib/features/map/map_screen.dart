import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocution = const LatLng(47.01, 28.86);
  late GoogleMapController googleMapController;
  Set<Marker> marker = {};

@override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }
  Future<void> _requestLocationPermission() async{
LocationPermission permission = await Geolocator.checkPermission();
if(permission == LocationPermission.denied){
  await Geolocator.requestPermission();
}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: marker,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: currentLocution,
          zoom: 15,
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          Position position = await currentPosition();
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 15,
                target: LatLng(position.latitude, position.longitude),
              ),
            ),
          );
          marker.clear();
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
}
