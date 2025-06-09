class QueryBean {
  QueryBean({
      this.floc, 
      this.silage,
  });

  String? floc;
  String? silage;

  String toStr() => "?floc=$floc&silage=$silage";
}