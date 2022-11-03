import 'package:flutter/material.dart';
import 'package:flutter_application_gallery/models/gallery_model.dart';
import 'package:flutter_application_gallery/services/get_gallery.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  ApiGetGallery api = ApiGetGallery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DataModel>(
        future: api.getGalleryService(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             print('hellw world${snapshot.data?.data.images}');
            return ListView.builder(
              itemCount: snapshot.data!.data.images.length,
              itemBuilder: ((context, i) {
                return ListTile(
                  leading: SizedBox(
                      child: Image.network(
                          '${snapshot.data!.data.images[i]}')),
                );
              }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
