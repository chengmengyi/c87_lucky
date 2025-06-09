class HeaderBean {
  HeaderBean({
      this.gondola, 
      this.navel,});

  HeaderBean.fromJson(dynamic json) {
    gondola = json['gondola'];
    navel = json['navel'];
  }
  String? gondola;
  String? navel;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gondola'] = gondola;
    map['navel'] = navel;
    return map;
  }

}