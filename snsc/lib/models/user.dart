class User {
  String? name;
  String email;
  String? password;
  String? dateOfBirth;
  String? location;
  String? disability;
  String? insurance;
  List<dynamic>? favoriteIds;
  bool? isAdmin;
  String? token;

  User(
      {this.name,
      required this.email,
      this.password,
      this.dateOfBirth,
      this.location,
      this.disability,
      this.insurance,
      this.favoriteIds,
      this.isAdmin,
      this.token});

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['dateOfBirth'] = dateOfBirth;
    _data['location'] = location;
    _data['disability'] = disability;
    _data['insurance'] = insurance;
    _data['favoriteIds'] = favoriteIds;
    _data['isAdmin'] = isAdmin;
    _data['token'] = token;
    return _data;
  }

  factory User.fromJson(Map<String, dynamic> Json) {
    User newUser = User(
        name: Json['name'],
        email: Json['email'],
        password: Json['password'],
        dateOfBirth: Json['dateOfBirth'],
        location: Json['location'],
        disability: Json['disability'],
        insurance: Json['insurance'],
        favoriteIds: Json['favoriteIds'],
        isAdmin: Json['isAdmin'],
        token: Json['token']);
    return newUser;
  }
}
