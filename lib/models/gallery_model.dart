import 'package:meta/meta.dart';
import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.data,
  });

  final Data data;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.images,
  });

  final List<String> images;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}