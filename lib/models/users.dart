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
  bool havePackages; 
  String accountName;
  String accountNumber;
  String bankName;
  bool isAdmin;

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
    this.havePackages,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.isAdmin,
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
    data['havePackages'] = user.havePackages;
    data['accountName'] = user.accountName;
    data['accountNumber'] = user.accountNumber;
    data['bankName'] = user.bankName;
    data['isAdmin'] = user.isAdmin;
   

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
    this.havePackages = mapData['havePackages'];
    this.accountName = mapData['accountName'];
    this.accountNumber = mapData['accountNumber'];
    this.bankName = mapData['bankName'];
    this.isAdmin = mapData['isAdmin'];
  }
}
