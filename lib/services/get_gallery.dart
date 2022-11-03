import 'package:flutter_application_gallery/models/gallery_model.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const Url = 'https://technichal.prominaagency.com/api/my-gallery';



class ApiGetGallery {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    var tokenvalue = prefs.getString('Token');
    
    return tokenvalue;
  }

  Future<DataModel> getGalleryService() async {
    http.Response response = await http.get(Uri.parse(Url),
        headers: {'Authorization': 'Bearer ${getToken()}'});


    var dataModel = dataModelFromJson(response.body);
    print('/*/*/*/*//////////////////////////////////${dataModel.data.images.length}');
   
    return dataModel;
  }
}
