import 'package:xml/xml.dart' as xml;

// inspired by https://github.com/xqwzts/feedparser

class FeedImage {
  final String? url;
  final String? width;
  final String? height;

  FeedImage(this.url, {this.width, this.height});

  factory FeedImage.fromXml(xml.XmlElement node) {
    String? url;
    try {
      url = node.findElements('url').single.text;
    } catch (e) {}

    String? width;
    try {
      width = node.findElements('width').single.text;
    } catch (e) {}

    String? height;
    try {
      height = node.findElements('height').single.text;
    } catch (e) {}

    return FeedImage(url, width: width, height: height);
  }

  String toString() {
    return '''
      url: $url
      width: $width
      height: $height
      ''';
  }
}

