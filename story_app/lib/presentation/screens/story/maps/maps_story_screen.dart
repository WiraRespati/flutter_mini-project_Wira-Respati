import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/story/location/location_story_bloc.dart';
import '../../../bloc/story/location/location_story_event.dart';
import '../../../bloc/story/location/location_story_state.dart';

class MapsStoryScreen extends StatefulWidget {
  const MapsStoryScreen({super.key});

  @override
  State<MapsStoryScreen> createState() => _MapsStoryScreenState();
}

class _MapsStoryScreenState extends State<MapsStoryScreen> {
  late GoogleMapController mapController;

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationStoryBloc>(context)
        .add(const LocationStoryButtonPressed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Story Locations'),
        elevation: 2,
      ),
      body: BlocBuilder<LocationStoryBloc, LocationStoryState>(
        builder: (context, state) {
          if (state is LocationStorySuccess) {
            for (var story in state.stories) {
              _markers.add(
                Marker(
                  markerId: MarkerId(story.name),
                  position:
                      LatLng(story.lat!.toDouble(), story.lon!.toDouble()),
                  infoWindow: InfoWindow(
                    title: story.name,
                    snippet: story.description,
                  ),
                ),
              );
            }
            LatLng center = calculateCenter(_markers);
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 2.0,
              ),
              markers: _markers,
            );
          } else if (state is LocationStoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationStoryFailure) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  LatLng calculateCenter(Set<Marker> markers) {
    double sumLat = 0;
    double sumLng = 0;

    for (Marker marker in markers) {
      sumLat += marker.position.latitude;
      sumLng += marker.position.longitude;
    }

    double avgLat = sumLat / markers.length;
    double avgLng = sumLng / markers.length;

    return LatLng(avgLat, avgLng);
  }
}
