// ignore_for_file: depend_on_referenced_packages

import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:find_logistic/src/app/constant/app_string.dart';

class AddressSearch {
  addressFieldTap({required BuildContext context}) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: mapApiKey,
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "ng",
      mode: Mode.overlay,
      language: "en",
      types: ["address"],
      onError: (response) {
        onError(response, context);
      },
      components: [Component(Component.country, "ng")],
    );
    return displayPrediction(p!);
  }

  void onError(PlacesAutocompleteResponse response, BuildContext context) {
    BottomSnack.errorSnackBar(
        message: response.errorMessage!, context: context);
  }

  displayPrediction(Prediction p) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: mapApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    // double lat = detail.result.geometry!.location.lat;
    // double lng = detail.result.geometry!.location.lng;
    // String address = detail.result.formattedAddress!;
    return detail.result;
    // print(lat);
    // print(lng);
    // print(address);
  }
}
