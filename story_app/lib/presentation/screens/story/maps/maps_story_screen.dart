import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/utils/constant/name_routes.dart';

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
    mapController.setMapStyle('''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''');
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
        title: const Text(
          'Story Locations',
          style: TextStyle(fontFamily: 'BriemHand'),
        ),
        elevation: 2,
      ),
      body: BlocBuilder<LocationStoryBloc, LocationStoryState>(
        builder: (context, state) {
          if (state is LocationStorySuccess) {
            for (var story in state.stories) {
              _markers.add(
                Marker(
                  markerId: MarkerId(story.name!),
                  position:
                      LatLng(story.lat!.toDouble(), story.lon!.toDouble()),
                  infoWindow: InfoWindow(
                    title: story.name,
                    snippet: story.description,
                    onTap: () {
                      Navigator.pushNamed(
                          context, NameRoutes.detailStoryPageRoute,
                          arguments: story.id);
                    },
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load stories: ${state.error}'),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        BlocProvider.of<LocationStoryBloc>(context)
                            .add(const LocationStoryButtonPressed());
                      },
                    )
                  ],
                ),
              ),
            );
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
