import 'package:find_logistic/src/app/model/driver_orders_model.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMap extends ConsumerWidget {
  final DriverOrders driverOrders;
  DriverMap({super.key, required this.driverOrders});

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(driverMapProvider);
    final model = ref.watch(driverMapProvider.notifier);
    final LatLng kMapCenter = LatLng(
        (double.parse(driverOrders.orderDetails!.orderFromLat)),
        (double.parse(driverOrders.orderDetails!.orderFromLong)));

    final LatLng kMapCenter2 = LatLng(
        //position of marker
        (double.parse(driverOrders.orderDetails!.orderToLat)),
        (double.parse(driverOrders.orderDetails!.orderToLong)));

    final CameraPosition kInitialPosition =
        CameraPosition(target: kMapCenter, zoom: 14.0, tilt: 0, bearing: 0);

    final Set<Marker> markers = {
      Marker(
        markerId: MarkerId(driverOrders.orderDetails!.orderFromAddress),
        position: kMapCenter, //position of marker
        infoWindow: const InfoWindow(
          title: 'Pickup Location',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: MarkerId(driverOrders.orderDetails!.orderToAddress),
        position: kMapCenter2,
        infoWindow: const InfoWindow(
          title: 'Delivery Location',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      )
    };

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: kInitialPosition,
            markers: markers,
            mapType: MapType.terrain,
            trafficEnabled: true,
            polylines: Set<Polyline>.of(model.polylines.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
        )
      ]),
    );
  }
}
