class UserAssets {
  String uid;
  int assetBalance;
  int appRevenue;
  int referralBonus;
  int payout;
  List currentPlans;
  

  UserAssets({
    this.uid,
    this.assetBalance,
    this.referralBonus,
    this.currentPlans, 
    this.payout,
    this.appRevenue,
   
  });

  Map toMap(UserAssets user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['assetBalance'] = user.assetBalance;
    data['referralBonus'] = user.referralBonus;
    data['currentPlans'] = user.currentPlans;
    data['payout'] = user.payout;
    data['appRevenue'] = user.appRevenue;
    

    return data;
  }

  // Named constructor
  UserAssets.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.assetBalance = mapData['assetBalance'];
    this.referralBonus = mapData['referralBonus'];
    this.currentPlans = mapData['currentPlans'];
    this.payout = mapData['payout'];
    this.appRevenue = mapData['appRevenue'];
    
  }
}
