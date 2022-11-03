import 'dart:io';
import 'package:flutter_application_gallery/models/gallery_model.dart';
import 'package:flutter_application_gallery/services/get_gallery.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var tokenvalue = prefs.getString('Token');

    return tokenvalue;
  }

  File? _image;
  String message = '';

  String url =
      'https://technichal.prominaagency.com/api/upload'; 
  bool loading = false;
  pickImage() async {
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    File newimage = File(pickedFile!.path);

    setState(() => _image = newimage);
  }

  upload(File file) async {
    if (file == null) return;

    setState(() {
      loading = true;
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getToken()}'
    };
    var uri = Uri.parse(url);
    var length = await file.length();
    // print(length);
    http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers);

    var respons = await http.Response.fromStream(await request.send());
    print(respons.statusCode);
    setState(() {
      loading = false;
    });
    if (respons.statusCode == 200) {
      setState(() {
        message = ' image upload with success';
      });
      return;
    } else
      setState(() {
        message = ' image not upload';
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.red],
              stops: [0.1, 3],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'WELCOME MINA',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset('lib/assets/Ellipse 1641.png'),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file),
                                Center(
                                  child: Text(
                                    'PICK',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          upload(_image!);
                          setState(() {});
                        },
                        child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file),
                                Text(
                                  'upload',
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder<DataModel>(
                    builder: (context, snapshot) => GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, crossAxisSpacing: 0.3),
                        itemBuilder: (context, index) => Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${snapshot.data!.data.images[index]}'),
                                  ),
                                ),
                              ),
                            ),
                        itemCount: snapshot.data!.data.images.length),
                    future: ApiGetGallery().getGalleryService(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
