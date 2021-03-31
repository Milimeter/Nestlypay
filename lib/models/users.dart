class UserData {
  String uid;
  String name;
  String email;
  String username;
  String password;
  String profilePhoto;
  String contactAddress;
  String referralLink;
  String phoneNo;
  bool infoFilled;

  UserData({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.password,
    this.profilePhoto,
    this.contactAddress,
    this.referralLink,
    this.phoneNo,
    this.infoFilled,
  });

  Map toMap(UserData user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data['password'] = user.password;
    data['profilePhoto'] = user.profilePhoto;
    data['contactAddress'] = user.contactAddress;
    data['referralLink'] = user.referralLink;
    data['phoneNo'] = user.phoneNo;
    data['infoFilled'] = user.infoFilled;

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
    this.contactAddress = mapData['contactAddress'];
    this.referralLink = mapData['referralLink'];
    this.phoneNo = mapData['phoneNo'];
    this.infoFilled = mapData['infoFilled'];
  }
}
