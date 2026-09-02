import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class MapPickerView extends StatefulWidget {
  const MapPickerView({super.key});

  @override
  State<MapPickerView> createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {
  GoogleMapController? _mapController;
  LatLng _pickedLocation = const LatLng(30.6605, 73.1608);
  String _address = '';
  final TextEditingController _searchController = TextEditingController();
  final Geocoding _geocoding = Geocoding();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    // FIX: cursor ko hamesha end pe rakho taake backspace/typing sahi kaam kare
    _searchController.addListener(() {
      final text = _searchController.text;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationServiceDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showPermissionDeniedDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _pickedLocation = LatLng(position.latitude, position.longitude);
      });

      _mapController?.animateCamera(CameraUpdate.newLatLng(_pickedLocation));
      _updateAddress(_pickedLocation);
    } catch (e) {
      debugPrint('Location error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error getting location: $e')));
    }
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
          'Please enable location services to use this feature.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
          'Please enable location permission in app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateAddress(LatLng location) async {
    try {
      List<Placemark> placemarks = await _geocoding.placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          _address = '${p.street}, ${p.locality}, ${p.administrativeArea}';
        });
      }
    } catch (e) {
      debugPrint('Geocoding error: $e');
      setState(() {
        _address = 'Address not available';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: SizedBox(
          height: 42,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: _searchController,
              googleAPIKey: "AIzaSyBKqoyowWC_4bXrm_L5zdJpX11TIlT0jco",
              inputDecoration: InputDecoration(
                hintText: "Location search karein...",
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              debounceTime: 600,
              countries: const ["pk"],
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                final lat = double.tryParse(prediction.lat ?? '');
                final lng = double.tryParse(prediction.lng ?? '');
                if (lat != null && lng != null) {
                  final newLocation = LatLng(lat, lng);
                  setState(() {
                    _pickedLocation = newLocation;
                  });
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(newLocation, 16),
                  );
                  _updateAddress(newLocation);
                }
              },
              itemClick: (Prediction prediction) {
                _searchController.text = prediction.description ?? '';
                _searchController.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description?.length ?? 0),
                );
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController = controller,
            onCameraMove: (position) => _pickedLocation = position.target,
            onCameraIdle: () => _updateAddress(_pickedLocation),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          const Center(
            child: Icon(Icons.location_pin, size: 45, color: Colors.red),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _address.isEmpty ? 'Fetching address...' : _address,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'lat': _pickedLocation.latitude,
                      'lng': _pickedLocation.longitude,
                      'address': _address,
                    });
                  },
                  child: const Text('Confirm Location'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
