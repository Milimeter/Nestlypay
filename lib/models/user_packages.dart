class UserPackages {
  String uid;
  String uniqueId;
  int amountPaid;
  int paidDate;
  int payoutDate;
  int payout;
  String currentPlan;
  DateTime visiblePaidDate;
  DateTime visiblePayoutDate;
  DateTime timeStamp;

  UserPackages(
      {this.uid,
      this.amountPaid,
      this.paidDate,
      this.currentPlan,
      this.payout,
      this.payoutDate,
      this.visiblePaidDate,
      this.visiblePayoutDate,
      this.timeStamp, 
      this.uniqueId});

  Map toMap(UserPackages user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['amountPaid'] = user.amountPaid;
    data['paidDate'] = user.paidDate;
    data['currentPlan'] = user.currentPlan;
    data['payout'] = user.payout;
    data['payoutDate'] = user.payoutDate;
    data['visiblePaidDate'] = user.visiblePaidDate;
    data['visiblePayoutDate'] = user.visiblePayoutDate;
    data['timeStamp'] = user.timeStamp;
    data['uniqueId'] = user.uniqueId;

    return data;
  }

  // Named constructor
  UserPackages.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.amountPaid = mapData['amountPaid'];
    this.paidDate = mapData['paidDate'];
    this.currentPlan = mapData['currentPlan'];
    this.payout = mapData['payout'];
    this.payoutDate = mapData['payoutDate'];
    this.visiblePaidDate = mapData['visiblePaidDate'];
    this.visiblePayoutDate = mapData['visiblePayoutDate'];
    this.timeStamp = mapData['timeStamp'];
    this.uniqueId = mapData['uniqueId'];
  }
}
