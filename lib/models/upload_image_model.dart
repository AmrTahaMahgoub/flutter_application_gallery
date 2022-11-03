// To parse this JSON data, do
//
//     final uploadImage = uploadImageFromJson(jsonString);

import 'dart:convert';

UploadImage uploadImageFromJson(String str) => UploadImage.fromJson(json.decode(str));

String uploadImageToJson(UploadImage data) => json.encode(data.toJson());

class UploadImage {
    UploadImage({
       required this.status,
       required this.data,
required this.message,
    });

    String? status;
    List<dynamic>? data;
    String? message;

    factory UploadImage.fromJson(Map<String, dynamic> json) => UploadImage(
        status: json["status"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "message": message,
    };
}
