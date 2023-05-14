import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/app/model/driver_orders_model.dart';
import 'package:find_logistic/src/screens/home/home.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMap extends ConsumerStatefulWidget {
  final DriverOrders driverOrders;
  const DriverMap({super.key, required this.driverOrders});

  @override
  ConsumerState<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends ConsumerState<DriverMap> {
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final model = ref.read(driverMapProvider.notifier);
      model.getDirections(
          double.parse(widget.driverOrders.orderDetails!.orderFromLat),
          double.parse(widget.driverOrders.orderDetails!.orderFromLong),
          double.parse(widget.driverOrders.orderDetails!.orderToLat),
          double.parse(widget.driverOrders.orderDetails!.orderToLong));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(driverMapProvider);
    final model = ref.watch(driverMapProvider.notifier);
    final endRide = ref.read(orderRequestProvider.notifier);
    final LatLng kMapCenter = LatLng(
        (double.parse(widget.driverOrders.orderDetails!.orderFromLat)),
        (double.parse(widget.driverOrders.orderDetails!.orderFromLong)));

    final LatLng kMapCenter2 = LatLng(
        //position of marker
        (double.parse(widget.driverOrders.orderDetails!.orderToLat)),
        (double.parse(widget.driverOrders.orderDetails!.orderToLong)));

    final CameraPosition kInitialPosition =
        CameraPosition(target: kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

    final Set<Marker> markers = {
      Marker(
        markerId: MarkerId(widget.driverOrders.orderDetails!.orderFromAddress),
        position: kMapCenter, //position of marker
        infoWindow: const InfoWindow(
          title: 'Pickup Location',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: MarkerId(widget.driverOrders.orderDetails!.orderToAddress),
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
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
        ),
        Column(children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false);
                  },
                  child: Material(
                    elevation: 5,
                    shape: const CircleBorder(),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.home_outlined,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.615,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(246, 255, 233, 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Name',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                      const SizedBox(height: 5),
                      Text(widget.driverOrders.orderDetails!.sendersName,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: blackColor)),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      Text('Phone',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(widget.driverOrders.orderDetails!.receiversPhone,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor)),
                          const Spacer(),
                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  primaryColor,
                                  const Color.fromRGBO(142, 176, 97, 1),
                                ],
                              ),
                            ),
                            child: Icon(
                              Icons.call,
                              color: whiteColor,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      Text('Pickup Add',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(153, 186, 102, 1))),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.fiber_manual_record,
                            color: Color.fromRGBO(153, 186, 102, 1),
                            size: 16,
                          ),
                          const SizedBox(width: 15),
                          Text(
                              widget
                                  .driverOrders.orderDetails!.orderFromAddress,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      Text('Delivery Add',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(252, 61, 61, 1))),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.fiber_manual_record,
                            color: Color.fromRGBO(252, 61, 61, 1),
                            size: 16,
                          ),
                          const SizedBox(width: 15),
                          Text(widget.driverOrders.orderDetails!.orderToAddress,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      Text('Price',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: primaryColor)),
                      const SizedBox(height: 5),
                      Text(
                          'N ${widget.driverOrders.orderDetails!.estimatedAmount}',
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: blackColor)),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Color.fromRGBO(217, 217, 217, 1),
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    endRide
                        .cancelOrder(
                            context: context,
                            orderRef: widget
                                .driverOrders.orderDetails!.orderReference)
                        .then((value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false,
                            ));
                  },
                  child: Container(
                    height: 47,
                    width: 206,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromRGBO(45, 95, 46, 1),
                          width: 1,
                        )),
                    child: Center(
                      child: Text('End Ride',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(45, 95, 46, 1))),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
