import 'package:flutter/material.dart';
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
      //  backgroundColor: Color(0xffedb4e6),
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffedb4e6), Color(0xffdeceff),Color(0xfffff6f6)],
            stops: [00.2, 0.6,0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Form(
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
                  Text('My ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                          Text('Gallery ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 18,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                       
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 2, color: Colors.white30)),
                      child: Column(children: [
                        Text('LOG IN ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
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
                                    UploadImageScreen(
                                        userName.text, password.text),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            width: double.infinity,
                            child: Center(child: Text('submit')),
                            decoration: BoxDecoration(
                                color: Color(0xff7bb3ff),
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
      ),
    );
  }
}
