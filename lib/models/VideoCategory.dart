class VideoCategory {
  int id;
  String cname;

  VideoCategory({this.id, this.cname});

  VideoCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cname = json['cname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['cname'] = this.cname;
    return data;
  }

  @override 
  String toString() {
    return 'VideoCategory{id: $id, cname: $cname}';
  }
}