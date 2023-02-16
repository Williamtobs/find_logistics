import 'package:find_logistic/src/screens/home/home.dart';
import 'package:find_logistic/src/screens/map/select_rider.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends ConsumerStatefulWidget {
  final bool driverPicked;
  final String? address, addressTo;
  const MapScreen(
      {super.key, this.driverPicked = false, this.address, this.addressTo});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? mapController;

  num? amount;
  // PolylinePoints polylinePoints = PolylinePoints();

  // Map<PolylineId, Polyline> polylines = {};

  // getDirections() async {
  //   List<LatLng> polylineCoordinates = [];
  //   final map = ref.watch(pickUpProvider);
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     mapApiKey,
  //     PointLatLng(double.parse(map.lat), double.parse(map.long)),
  //     PointLatLng(double.parse(map.latTo), double.parse(map.longTo)),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }
  //   } else {
  //     print(result.errorMessage);
  //   }
  //   addPolyLine(polylineCoordinates);
  // }

  @override
  void initState() {
    super.initState();
    final model = ref.read(pickUpProvider.notifier);
    model.getDirections(
        model.pickUpDetailsResponse!.geometry!.location.lat,
        model.pickUpDetailsResponse!.geometry!.location.lng,
        model.placesDetailsResponse!.geometry!.location.lat,
        model.placesDetailsResponse!.geometry!.location.lng);
    amount = ref.watch(orderProvider).orderDetails.estimatedAmount;
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(orderProvider);
    final LatLng kMapCenter = LatLng(
        (model.pickUpDetailsResponse!.geometry!.location.lat),
        (model.pickUpDetailsResponse!.geometry!.location.lng));

    final LatLng kMapCenter2 = LatLng(
        model.placesDetailsResponse!.geometry!.location.lat,
        model.placesDetailsResponse!.geometry!.location.lng);

    final CameraPosition kInitialPosition =
        CameraPosition(target: kMapCenter, zoom: 14.0, tilt: 0, bearing: 0);

    final Set<Marker> markers = {
      Marker(
        markerId: MarkerId(widget.address!),
        position: kMapCenter, //position of marker
        infoWindow: const InfoWindow(
          title: 'Pickup Location',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: MarkerId(widget.addressTo!),
        position: kMapCenter2,
        infoWindow: const InfoWindow(
          title: 'Delivery Location',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      )
    };
    //getDirections();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: kInitialPosition,
              mapType: MapType.terrain,
              trafficEnabled: true,
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(
                  ref.watch(pickUpProvider.notifier).polylines.values),
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
                              Icons.arrow_back,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
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
              const Spacer(),
              widget.driverPicked
                  ? const SeledtedDriver()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          )),
                      child: SelectedLocation(
                        addressFrom: widget.address!,
                        addressTo: widget.addressTo!,
                        amount: amount!,
                        onTap: () {
                          setState(() {
                            amount = amount! - 100;
                          });
                        },
                        onTap2: () {
                          setState(() {
                            amount = amount! + 100;
                          });
                        },
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}

class SeledtedDriver extends StatelessWidget {
  
  const SeledtedDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Amadi Obi is on his way...',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star_border_outlined,
                          color: Color.fromRGBO(153, 186, 102, 1),
                          size: 16,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Color.fromRGBO(153, 186, 102, 1),
                          size: 16,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Color.fromRGBO(153, 186, 102, 1),
                          size: 16,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rating from 94 completed rides',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Amount',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'N900',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Arrival Time',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '10 minutes',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: 140,
                        child: CustomButton(
                          text: 'Cancel Ride',
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                (route) => false);
                            //SelectRider
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Material(
            elevation: 5,
            shape: const CircleBorder(),
            child: Container(
              width: 75,
              height: 75,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/rider_img.png'),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SelectedLocation extends ConsumerWidget {
  final String addressFrom, addressTo;
  final num amount;
  final Function()? onTap, onTap2;
  const SelectedLocation({
    super.key,
    required this.addressFrom,
    required this.addressTo,
    required this.amount,
    this.onTap,
    this.onTap2,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(mapProvider);
    final trnRef = ref.read(orderProvider);
    final order = ref.watch(mapProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const Icon(
              Icons.fiber_manual_record,
              color: Color.fromRGBO(153, 186, 102, 1),
              size: 8,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                addressFrom,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Color.fromRGBO(217, 217, 217, 1),
            thickness: 1,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Icon(
              Icons.fiber_manual_record,
              color: Color.fromRGBO(252, 61, 61, 1),
              size: 8,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                addressTo,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Color.fromRGBO(217, 217, 217, 1),
            thickness: 1,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 41,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(153, 186, 102, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: onTap,
                  child:
                      const Icon(Icons.remove, color: Colors.white, size: 20)),
              Text(
                'NGN $amount',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                  onTap: onTap2,
                  child: const Icon(Icons.add, color: Colors.white, size: 20)),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: SizedBox(
            width: 140,
            child: CustomButton(
              text: 'Find rider',
              isLoading: orderState.isLoading,
              onTap: () {
                order.negotiateOrder(context: context, formData: {
                  "order_reference": trnRef.orderDetails.orderReference,
                  "amount": amount.toString(),
                }).then((value) {
                  if (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectRider(
                                  amount: amount,
                                  orderRef: trnRef.orderDetails.orderReference,
                                )));
                  }
                });

                //SelectRider
              },
            ),
          ),
        ),
      ],
    );
  }
}
