import 'VideoCategory.dart';

class VideoCategoryList {
  int status;
  List<VideoCategory> data;

  VideoCategoryList({this.status, this.data});

  VideoCategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = List<VideoCategory>();
      json['data'].forEach((v) {
        data.add(VideoCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}