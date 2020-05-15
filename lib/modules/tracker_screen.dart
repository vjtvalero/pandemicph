import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:pandemicph/src/strings.dart';
import 'package:pandemicph/src/theme.dart';
import 'package:pandemicph/models/user.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loclib;
import 'package:pandemicph/src/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CameraPosition _initialLatLng =
      CameraPosition(target: LatLng(14.7389, 121.1014), zoom: 10);
  GoogleMapController _controller;
  loclib.Location _loc = new loclib.Location();
  final Map<String, Marker> _markers = {};
  static const _defaultUserAddress = 'My address...';
  String _userAddress = _defaultUserAddress;
  bool _addressExpanded = false;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    final UserLocation userLoc = await _getLocation();
    _updateCamera(userLoc);
    _updateMarkers(userLoc);
  }

  Future<UserLocation> _getLocation() async {
    final SharedPreferences prefs = await _prefs;
    List<String> userLoc = prefs.getStringList('userLatLng');
    if (userLoc != null && userLoc.isNotEmpty) {
      return new UserLocation(
        latitude: double.parse(userLoc[0]),
        longitude: double.parse(userLoc[1]),
      );
    } else {
      loclib.LocationData userLoc = await _updateCurrentLoc();
      return new UserLocation(
        latitude: userLoc.latitude,
        longitude: userLoc.longitude,
      );
    }
  }

  void _updateCamera(UserLocation newLoc) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        newLoc.latitude,
        newLoc.longitude,
      ),
      zoom: 13,
    )));
  }

  void _updateMarkers(UserLocation newLoc) {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId('self'),
        position: LatLng(newLoc.latitude, newLoc.longitude),
      );
      _markers['self'] = marker;
    });
  }

  Future<loclib.LocationData> _updateCurrentLoc() async {
    final SharedPreferences prefs = await _prefs;
    loclib.LocationData userLoc = await _loc.getLocation();
    prefs.setStringList('userLatLng',
        [userLoc.latitude.toString(), userLoc.longitude.toString()]);
    final coords = new Coordinates(userLoc.latitude, userLoc.longitude);
    final addresses = await Geocoder.local.findAddressesFromCoordinates(coords);
    setState(() {
      _userAddress = addresses.first.addressLine;
    });
    return userLoc;
  }

  void _updateLocAndCam() async {
    loclib.LocationData newLoc = await _updateCurrentLoc();
    UserLocation newUserLoc = new UserLocation(
        latitude: newLoc.latitude, longitude: newLoc.longitude);
    _updateCamera(newUserLoc);
    _updateMarkers(newUserLoc);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: _initialLatLng,
          onMapCreated: _onMapCreated,
          markers: _markers.values.toSet(),
        ),
        Positioned(
          top: 35,
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: googleAPIKey,
                    language: 'US',
                    components: [Component(Component.country, 'PH')],
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.place,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search for positive cases',
                        style: TextStyle(
                            color: mutedColor,
                            fontSize: 16,
                            letterSpacing: 0.5),
                      )
                    ],
                  ),
                ),
              ),
              WidgetSpacer(size: 'thin'),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _addressExpanded = !_addressExpanded;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 340,
                        child: Text(
                          _userAddress,
                          style: TextStyle(
                            color: mutedColor,
                            fontSize: 14,
                          ),
                          overflow: _addressExpanded == true
                              ? null
                              : TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 105,
          right: 13,
          width: 35,
          height: 35,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey,
            child: Icon(
              Icons.my_location,
              size: 20,
            ),
            onPressed: () {
              _updateLocAndCam();
            },
          ),
        ),
      ],
    );
  }
}
