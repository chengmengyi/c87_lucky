class CashTaskBean {
  CashTaskBean({
      this.payTypeIndex, 
      this.payMoney, 
      this.taskType, 
      this.currentPro, 
      this.totalPro, 
      this.task3Index,
      this.cashStatus,
  });

  CashTaskBean.fromJson(dynamic json) {
    payTypeIndex = json['payTypeIndex'];
    payMoney = json['payMoney'];
    taskType = json['taskType'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
    task3Index = json['task3Index'];
    cashStatus = json['cashStatus'];
  }
  int? payTypeIndex;
  int? payMoney;
  String? taskType;
  int? currentPro;
  int? totalPro;
  int? task3Index;
  int? cashStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payTypeIndex'] = payTypeIndex;
    map['payMoney'] = payMoney;
    map['taskType'] = taskType;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    map['task3Index'] = task3Index;
    map['cashStatus'] = cashStatus;
    return map;
  }
}