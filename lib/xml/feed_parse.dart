import 'package:flexi_reader/xml/feed.dart';
import 'package:xml/xml.dart' as xml;

// inspired by https://github.com/xqwzts/feedparser

Feed? parseFeed(String feedString) {
  try {
    xml.XmlDocument document = xml.XmlDocument.parse(feedString);

    xml.XmlElement channelElement =
        document.rootElement.findElements('channel').single;
    Feed feed = Feed.fromXml(channelElement);
    return feed;
  } catch (e) {
    print('parseXmlFeed exception: $e');
    return null;
  }

}
