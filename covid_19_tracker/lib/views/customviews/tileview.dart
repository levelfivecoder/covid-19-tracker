
import 'package:covid_19_tracker/business/enums/status.dart';
import 'package:flutter/material.dart';

class TileView extends StatelessWidget {
  Status tileStatus;
  int count = 0;
  Color color;
  String tileText;
  TileView(this.tileStatus, this.count) {
    switch (tileStatus) {
      case Status.confirmed:
        tileText = 'Confirmed';
        color = Colors.orange;
        break;
      case Status.deaths:
        tileText = 'Deaths';
        color = Colors.red;
        break;
      case Status.recovered:
        tileText = 'Recoverd';
        color = Colors.green;
        break;
      default:
        tileText = 'No data';
        color = Colors.white;
        count=0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 150,
      width: double.infinity,
      child: Card(
          color: Color(0xFF121212),
          elevation: 15,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: tileText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: count.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          ),
    );
  }
}
