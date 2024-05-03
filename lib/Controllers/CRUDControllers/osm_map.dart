import 'package:admintest/Controllers/CRUDControllers/shops_api.dart';
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:permission_handler/permission_handler.dart';

class ShopMap extends StatefulWidget {
  const ShopMap({super.key, required this.name});
  final String name;

  @override
  State<ShopMap> createState() => _ShopMapState();
}

class _ShopMapState extends State<ShopMap> {
  ShopApiCall _shopApiCall = ShopApiCall();
  late Future<List<LatLng>> routePointsFuture;
  late Future<void> tilesFuture;
  late LatLng userPosition;
  late LatLng shopPosition;
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    tilesFuture = Future.value(); // You can add tile fetching here if needed
  }

  Future<void> _getUserLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    dynamic shop = await _shopApiCall.getShopByName(widget.name);
    if (shop != null) {
      // Access the content of shop
      print('Shop Name: ${shop.name}');

      setState(() {
        userPosition = LatLng(position.latitude, position.longitude);
        shopPosition = LatLng(shop.coordinates.latitude, shop.coordinates.longitude);
        routePointsFuture = fetchRoutePoints(
          userPosition,
          LatLng(shop.coordinates.latitude, shop.coordinates.longitude),
        ).whenComplete(() => setState(() {
              isLoading = false;
            }));
      });
    }
  } catch (e) {
    print("Error getting user location: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Shop Location",style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600,color: darkBrown),),
        centerTitle: true,
        backgroundColor: backgoundColor,
        elevation: 1,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: darkBrown,))
          : FutureBuilder(
              future: Future.wait([routePointsFuture, tilesFuture]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color:darkBrown,));
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  List<LatLng> routePoints = snapshot.data![0];
                  // You can access tile data using snapshot.data![1]
                  return FlutterMap(
                    options: MapOptions(
                      initialCenter: userPosition,
                      initialZoom: 13,
                      interactionOptions: const InteractionOptions(
                          flags: ~InteractiveFlag.doubleTapDragZoom),
                    ),
                    children: [
                      openStreetMapTileLayer,
                      MarkerLayer(
                        markers: [
                           Marker(
                            point: shopPosition,
                            width: 50,
                            height: 50,
                            alignment: Alignment.topCenter,
                            child: const Icon(Icons.location_pin,
                                size: 60, color: Colors.red),
                          ),
                          Marker(
                            point: routePoints.first,
                            width: 60,
                            height: 60,
                            alignment: Alignment.topCenter,
                            child: const Icon(Icons.person_pin_circle_rounded,
                                size: 55,
                                color: Color.fromARGB(255, 74, 3, 206)),
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: routePoints,
                            strokeWidth: 4.0,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.exemple',
      );

  Future<List<LatLng>> fetchRoutePoints(LatLng start, LatLng end) async {
    final url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?steps=true&annotations=true&geometries=geojson&overview=full');
    final response = await http.get(url);
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = decoded['routes'] as List<dynamic>;
    if (routes.isEmpty) {
      throw Exception('No routes found');
    }
    final geometry = routes[0]['geometry']['coordinates'] as List<dynamic>;
    return geometry
        .map<LatLng>((coord) => LatLng(coord[1] as double, coord[0] as double))
        .toList();
  }
}