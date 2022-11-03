import 'package:flutter/material.dart';
import 'package:flutter_application_gallery/screens/gallery_screen.dart';
import 'package:flutter_application_gallery/screens/upload_image_screen.dart';
import 'package:flutter_application_gallery/services/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userName = TextEditingController();
  var password = TextEditingController();
  final GlobalKey formKey = GlobalKey<FormState>();
  LoginApi loginAut = LoginApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    heightFactor: 0.2,
                    alignment: Alignment.bottomLeft,
                    child: Image.asset('lib/assets/love_photography.png')),
                SizedBox(
                  height: 18,
                ),
                Text('My Gallery',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 18,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2, color: Colors.white30)),
                    child: Column(children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        controller: userName,
                        
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "user name",
                            fillColor: Colors.white70),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required';
                          }
                          return null;
                        },
                        controller: password,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "password",
                            fillColor: Colors.white70),

                       
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {});
                          await loginAut.userLogin(
                              userName.text, password.text);

                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const GalleryScreen(),
                            ),
                          );
                          //${userName.text}${password.text}
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          width: double.infinity,
                          child: Center(child: Text('submit')),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
