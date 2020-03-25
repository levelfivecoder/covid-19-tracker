import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Covid 19 Tracker",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Text("github link",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                  )),
              onTap: () async {
                String url = "https://github.com/levelfivecoder/covid-19-tracker";
                await launch(url, enableJavaScript: true);
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: RaisedButton(
          //     child: Text('Share Application'),
          //     onPressed: () async {
          //       var response = await FlutterShareMe().shareToSystem(
          //           msg:
          //               "Hey check out covid 19 tracker app at: https://play.google.com/store/apps/details?id=com.levelfivecoder.covid_19_tracker");
          //       if (response == 'success') {
          //         print('navigate success');
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
