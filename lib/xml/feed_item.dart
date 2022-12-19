import 'package:flexi_reader/xml/feed_enclosure.dart';
import 'package:xml/xml.dart' as xml;

// inspired by https://github.com/xqwzts/feedparser

class FeedItem {
  final String? title;
  final String? link;
  final String? description;
  final String? thumbnail;
  final FeedEnclosure? enclosure;
  final String? pubDate;
  final FeedEnclosure? mediaContent;
  final FeedEnclosure? mediaThumbnail;

  FeedItem(
      {this.title,
      this.link,
      this.description,
      this.thumbnail,
      this.enclosure,
      this.pubDate,
      this.mediaContent,
      this.mediaThumbnail});

  factory FeedItem.fromXml(xml.XmlElement node) {
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

    String thumbnail = '';
    try {
      thumbnail = node.findElements('thumbnail').single.text;
    } catch (e) {}

    String pubDate = '';
    try {
      pubDate = node.findElements('pubDate').single.text;
    } catch (e) {}

    // item enclosure
    xml.XmlElement? enclosureElement;
    try {
      enclosureElement = node.findElements('enclosure').single;
    } catch (e) {}

    FeedEnclosure enclosure = FeedEnclosure('','','');
    if (enclosureElement != null) {
      enclosure = new FeedEnclosure.fromXml(enclosureElement);
    }

    // item media:content
    xml.XmlElement? mediaContentElement;
    try {
      mediaContentElement = node.findElements('media:content').first;
    } catch (e) {}

    FeedEnclosure mediaContent = FeedEnclosure('','','');
    if (mediaContentElement != null) {
      mediaContent = new FeedEnclosure.fromXml(mediaContentElement);
    }

    // item media:thumbnail
    xml.XmlElement? mediaThumbnailElement;
    try {
      mediaThumbnailElement = node.findElements('media:thumbnail').first;
    } catch (e) {}

    FeedEnclosure mediaThumbnail = FeedEnclosure('','','');
    if (mediaThumbnailElement != null) {
      mediaThumbnail = new FeedEnclosure.fromXml(mediaThumbnailElement);
    }

    return new FeedItem(
        title: title,
        link: link,
        description: description,
        thumbnail: thumbnail,
        enclosure: enclosure,
        pubDate: pubDate,
        mediaContent: mediaContent,
        mediaThumbnail: mediaThumbnail);
  }

  String toString() {
    return '''
      title: $title
      link: $link
      description: $description
      thumbnail: $thumbnail
      enclosure: $enclosure
      pubDate: $pubDate
      mediaContent: $mediaContent
      mediaThumbnail: $mediaThumbnail
      ''';
  }
}

