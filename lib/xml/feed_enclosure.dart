import 'package:xml/xml.dart' as xml;

// inspired by https://github.com/xqwzts/feedparser

class FeedEnclosure {
  final String? url;

  /// Size in bytes
  final String? length;

  /// MIME type
  final String? type;

  FeedEnclosure(this.url, this.length, this.type);

  factory FeedEnclosure.fromXml(xml.XmlElement node) {
    String? url;
    try {
      url = node.getAttribute('url');
    } catch (e) {}

    String? length;
    try {
      length = node.getAttribute('length');
    } catch (e) {}

    String? type;
    try {
      type = node.getAttribute('type');
    } catch (e) {}

    return new FeedEnclosure(url, length, type);
  }

  String toString() {
    return '''
      url: $url
      length: $length
      type: $type
      ''';
  }
}
