class UserDataModel {
  final UserModel userModel;
  final String token;

  UserDataModel({required this.userModel, required this.token});
  factory UserDataModel.fromJson(json) {
    return UserDataModel(
        userModel: UserModel.fromJson(json['user']), token: json['token']);
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String email_verified_at;
  final String created_at;
  final String updated_at;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.email_verified_at,
      required this.created_at,
      required this.updated_at});
  factory UserModel.fromJson(json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        email_verified_at: json['email_verified_at'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }
}