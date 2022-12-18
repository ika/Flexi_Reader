
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// var encoded;
// late String pageTitle;

// class WebPage extends StatefulWidget {
//   WebPage(String uri, String t) {
//     encoded = Uri.encodeFull(uri);
//     pageTitle = t;
//   }

//   @override
//   _WebPageState createState() => _WebPageState();
// }

// class _WebPageState extends State<WebPage> {
//   //Completer<WebViewController> _controller = Completer<WebViewController>();

//   int position = 1;

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   String _shortenTitle(String n) {
//     int len = 25;
//     return (n.length > len) ? n.substring(0, len) + ' ...' : n;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(_shortenTitle(pageTitle)),
//           actions: [],
//         ),
//         body: IndexedStack(
//           index: position,
//           children: [
//             WebView(
//               initialUrl: encoded,
//               javascriptMode: JavascriptMode.unrestricted,
//               // onWebViewCreated: (WebViewController webViewController) {
//               //   _controller.complete(webViewController);
//               // },
//               onPageStarted: (value) {
//                 setState(() {
//                   position = 1;
//                 });
//               },
//               onPageFinished: (value) {
//                 setState(() {
//                   position = 0;
//                 });
//               },
//             ),
//             Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           ],
//         ));
//   }
// }
