// Feed Cache

class CModel {
  int? _id;
  String? _title;
  String? _link;
  String? _desc;
  String? _imageurl;
  int? _pdate;
  int? _feedid;
  int? _time;

  CModel(this._title, this._link, this._desc, this._imageurl, this._pdate,
      this._feedid, this._time);

  CModel.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._link = obj['link'];
    this._desc = obj['desc'];
    this._imageurl = obj['imageurl'];
    this._pdate = obj['pdate'];
    this._feedid = obj['feedid'];
    this._time = obj['time'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['link'] = _link;
    map['desc'] = _desc;
    map['imageurl'] = _imageurl;
    map['pdate'] = _pdate;
    map['feedid'] = _feedid;
    map['time'] = _time;

    return map;
  }

  CModel.fromMap(dynamic map) {
    this._id = map['id'];
    this._title = map['title'];
    this._link = map['link'];
    this._desc = map['desc'];
    this._imageurl = map['imageurl'];
    this._pdate = map['pdate'];
    this._feedid = map['feedid'];
    this._time = map['time'];
  }
}
