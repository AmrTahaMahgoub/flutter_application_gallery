import 'dart:developer';

import 'package:flutter_application_gallery/models/gallery_model.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const Url = 'https://technichal.prominaagency.com/api/my-gallery';

class ApiGetGallery {


  Future<DataModel> getGalleryService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   var mytoken= prefs.getString('Token');
    http.Response response = await http.get(Uri.parse(Url), headers: {
      'Authorization':'Bearer ${mytoken}'
    });

    var dataModel = dataModelFromJson(response.body);
  

    return dataModel;
  }
}
