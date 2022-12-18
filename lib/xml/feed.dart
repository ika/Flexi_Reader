import 'package:flexi_reader/xml/feed_image.dart';
import 'package:flexi_reader/xml/feed_item.dart';
import 'package:xml/xml.dart' as xml;

// inspired by https://github.com/xqwzts/feedparser

class Feed {
  final String? title;
  final String? link;
  final String? description;
  final String? language;
  final String? pubDate;
  final FeedImage? image;
  final List<FeedItem>? items;

  Feed(
    this.title,
    this.link,
    this.description, {
    this.language,
    this.pubDate,
    this.image,
    this.items,
  });

  // initializeFeed(){
  //   return Feed (
  //     title,
  //     link,
  //     description,
  //     image: image,
  //     language: language,
  //     pubDate: pubDate,
  //     items: items,
  //   );
  // }

  factory Feed.fromXml(xml.XmlElement node) {
    String title = '';
    try {
      title = node.findElements('title').single.text;
    } catch (e) {}

    String link = '';
    try {
      link = node.findElements('link').single.text;
    } catch (e) {}

    String description = '';
    try {
      description = node.findElements('description').single.text;
    } catch (e) {}

    String language = '';
    try {
      language = node.findElements('language').single.text;
    } catch (e) {}

    String pubDate = '';
    try {
      pubDate = node.findElements('pubDate').single.text;
    } catch (e) {}

    xml.XmlElement? imageElement;
    try {
      imageElement = node.findElements('image').single;
    } catch (e) {}

    FeedImage image = FeedImage('assets/images/no_image.png');
    if (imageElement != null) {
      try {
        image = FeedImage.fromXml(imageElement);
      } catch (e) {}
    }

    List<FeedItem> items = node
        .findElements('item')
        .map((itemElement) => FeedItem.fromXml(itemElement))
        .toList();

    return new Feed(
      title,
      link,
      description,
      image: image,
      language: language,
      pubDate: pubDate,
      items: items,
    );
  }

  String toString() {
    return '''
      title: $title
      link: $link
      description: $description
      language: $language
      pubDate: $pubDate
      image: $image
      items: $items
      ''';
  }
}
