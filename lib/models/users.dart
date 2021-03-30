class UserData {
  String uid;
  String name;
  String email;
  String username;
  String password;
  String profilePhoto;
  bool otpVerified;
  String token;
  String phone;

  UserData({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.password,
    this.profilePhoto,
  });

  Map toMap(UserData user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data['password'] = user.password;
    data['profilePhoto'] = user.profilePhoto;

    return data;
  }

  // Named constructor
  UserData.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.password = mapData['password'];
    this.profilePhoto = mapData['profilePhoto'];
  }
}
