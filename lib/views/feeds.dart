import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/database.dart';
import '../models/fmodel.dart';
import '../models/jmodel.dart';
import '../views/edit.dart';

// feeds.dart

DBProvider dbProvider = DBProvider();

class FeedsPage extends StatefulWidget {
  FeedsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  var _fapLocation = FloatingActionButtonLocation.endDocked;

  // @override
  // void initState() {
  //   super.initState();
  // }

  void _encodeFeedListItemData(FModel fmodel) async {
    final String encodedData = JModel.encode([
      JModel(title: fmodel.title, link: fmodel.link, feedid: fmodel.feedid),
    ]);

    //print(encodedData);

    // save encoded data
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString("jmodelEncodedData", encodedData);
    });
    // update feed item time stamp
    await _updateFeedListItemTime(fmodel).then((value) {
      // return to News
      Navigator.pop(context, encodedData);
    });
  }

  // update time stamp
  Future<Null> _updateFeedListItemTime(FModel fmodel) async {
    fmodel.time = new DateTime.now().microsecondsSinceEpoch;
    dbProvider.updateFeedItem(fmodel);
  }

  String shortenTitle(String n) {
    int len = 40;
    String title = (n.length > len) ? n.substring(0, len) + '...' : n;
    return title;
  }

  FutureOr onReturnFromEditPage(dynamic value) {
    setState(() {});
  }

  _navigateToEditPage(FModel fModel) async {
    Route route =
        CupertinoPageRoute(builder: (context) => EditPage(fModel: fModel));
    Navigator.push(context, route).then(onReturnFromEditPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // this is the default
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<FModel>>(
                future: dbProvider.getAllFeedItems(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<FModel>> snapshot) {
                  // Make sure data exists and is actually loaded
                  if (snapshot.hasData) {
                    // If there are no notes (data), display this message.
                    if (snapshot.data?.length == 0) {
                      return Center(
                        child: Text('No items found'),
                      );
                    }

                    List<FModel> data = snapshot.data!;

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 88),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        FModel fmodel = data[index];

                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(shortenTitle(fmodel.title!)),
                              onTap: () {
                                _encodeFeedListItemData(fmodel);
                              },
                              onLongPress: () {
                                _navigateToEditPage(fmodel);
                              },
                              leading:
                                  Icon(Icons.chevron_right, color: Colors.blue),
                            ),
                            Divider(
                              height: 2.0,
                              indent: 15.0,
                              endIndent: 20.0,
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToEditPage(FModel(id: null, title: '', link: ''));
        },
        child: Icon(Icons.add),
        tooltip: 'Add feed',
      ),
      floatingActionButtonLocation: _fapLocation,
      bottomNavigationBar: _BottomAppBar(
        fabLocation: _fapLocation,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar({
    required this.fabLocation,
    required this.shape,
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape shape;

  static final centerLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      child: IconTheme(
        data: IconThemeData(color: Colors.blue),
        child: Row(
          children: [
            IconButton(
              tooltip: '',
              icon: const Icon(Icons.menu),
              onPressed: () {
                print('Menu button pressed');
              },
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Tooltip',
              icon: const Icon(Icons.search),
              onPressed: () {
                print('Search button pressed');
              },
            ),
            IconButton(
              tooltip: 'tooltip',
              icon: const Icon(Icons.favorite),
              onPressed: () {
                print('Favorite button pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
