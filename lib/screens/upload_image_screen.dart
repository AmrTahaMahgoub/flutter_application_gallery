import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_gallery/models/gallery_model.dart';
import 'package:flutter_application_gallery/models/user_model.dart';
import 'package:flutter_application_gallery/services/get_gallery.dart';
import 'package:flutter_application_gallery/services/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class UploadImageScreen extends StatefulWidget {
  UploadImageScreen(this.email, this.password);
  String? email;
  String? password;

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  String message = '';

  String url = 'https://technichal.prominaagency.com/api/upload';
  bool loading = false;
  pickImageFromGallery() async {
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    File newimage = File(pickedFile!.path);

    setState(() => _image = newimage);
  }

  pickImageFromCamera() async {
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);
    File newimage = File(pickedFile!.path);

    setState(() => _image = newimage);
  }

  upload(File file) async {
    if (file == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var tokenvalue = prefs.getString('Token');

    setState(() {
      loading = true;
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${tokenvalue}'
    };

    var uri = Uri.parse(url);
    var length = await file.length();
    var path = await file.path;

    log('length ${path.toString()}');
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('img', '$path'));
    request.headers.addAll(headers);

    var respons = await http.Response.fromStream(
      await request.send(),
    );
    log('${respons.body}');
    setState(() {
      loading = false;
    });
    if (respons.statusCode == 200) {
      setState(() {
        message = 'image upload with success';
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
              colors: [Color(0xffebe1ff), Color(0xfffff9f9)],
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
                    FutureBuilder<UserDataModel>(
                      future: LoginApi().userLogin(
                          widget.email.toString(), widget.password.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'Welcome \n${snapshot.data?.userModel.name}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
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
                        onTap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.remove('Token');
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_circle_left_rounded,color: Colors.red,size: 35),
                                SizedBox(
                                  width: 18,
                                ),
                                Center(
                                  child: Text(
                                    'log out',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          setState(() {});
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              backgroundColor: Colors.white.withOpacity(0.6),
                              content: SizedBox(
                                height: 200,
                                width: 170,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        await pickImageFromGallery();
                                        Navigator.pop(context);
                                        await upload(_image!);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 40),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.g_translate_outlined),
                                            Text(
                                              '  Gallery',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade800),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        await pickImageFromCamera();
                                        Navigator.pop(context);
                                        await upload(_image!);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 40),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.camera_alt),
                                              Text('  Camera',
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .grey.shade800)),
                                            ],
                                          )),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_circle_up_rounded,
                                color: Colors.orange,size: 35),
                                SizedBox(
                                  width: 18,
                                ),
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
                      future: ApiGetGallery().getGalleryService(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                              padding: const EdgeInsets.all(10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      //color: Color(0xfffff9f9),
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 25,
                                      mainAxisSpacing: 25),
                              itemBuilder: (context, index) => Container(
                                    color: Color(0xffebe1ff),
                                   // elevation: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.data.images[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                              itemCount: snapshot.data?.data.images.length);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
