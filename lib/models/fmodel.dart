class FModel {
  int? id;
  String? title;
  String? link;
  int? feedid;
  int? time;

  FModel({this.id, this.title, this.link, this.feedid, this.time});

  FModel.map(dynamic obj) {
    this.id = obj['id'];
    this.title = obj['title'];
    this.link = obj['link'];
    this.feedid = obj['feedid'];
    this.time = obj['time'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['link'] = link;
    map['feedid'] = feedid;
    map['time'] = time;

    return map;
  }

  FModel.fromMap(dynamic map) {
    this.id = map['id'];
    this.title = map['title'];
    this.link = map['link'];
    this.feedid = map['feedid'];
    this.time = map['time'];
  }
}
