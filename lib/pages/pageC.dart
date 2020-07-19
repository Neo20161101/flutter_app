import 'package:flutter/material.dart';

class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('pageC'),
        ),
        body: new ListView(
          children: <Widget>[
            titleSection,
            contentSection,
            contentSection1,
            contentSection2,
            contentSection3,
            contentSection4,
            contentSection5,
            contentSection6(context)
          ],
        ));
  }

  Widget titleSection = new Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
//      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Container(
              height: 50,
              child: new Text('Around'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              height: 50,
              child: new Text('Around'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              height: 50,
              child: new Text('Around'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Around'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              height: 50,
              child: new Text('Around'),
            )
          ],
        ),
      ],
    ),
  );

  Widget contentSection = new Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
              ),
              child: new Text('Evenly'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Evenly'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Evenly'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Evenly'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Evenly'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection1 = new Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
              ),
              child: new Text('Between'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Between'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Between'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Between'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('Between'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection2 = new Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: new Row(
      children: <Widget>[
        new Expanded(
            child: new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child: new Text('Expanded'),
        )),
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new Text('Expanded'),
              ),
              new Container(
                child: new Text('Expanded'),
              )
            ],
          ),
        ),
        new Expanded(
          child: new Container(
            child: new Text('Expanded'),
          ),
        ),
        new Expanded(
          child: new Container(
            child: new Text('Expanded'),
          ),
        ),
        new Expanded(
            child: new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child: new Text('Expanded'),
        )),
      ],
    ),
  );
  Widget contentSection3 = new Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('start2start2start2start2'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('start2'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('start2'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('start2'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('start2'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection4 = new Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('end3'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('end3'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('end3'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('end3'),
            )
          ],
        ),
        new Column(
          children: <Widget>[
            new Container(
              child: new Text('end3'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection5 = new Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Text('spaceBetween'),
            )
          ],
        ),
        new Column(
//          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
              child: new Text('spaceBetween4'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection6(context) => new Container(
    padding: const EdgeInsets.only(top: 32.0),
    height: 300,
    child: new GridView.extent(
      maxCrossAxisExtent: 80,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          height: 100,
          child:new Text('GridView'),
        ),
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:new Text('GridView'),
        ),
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:new Text('GridView'),
        ),
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:new Text('GridView'),
        ),
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:new Text('GridView'),
        ),
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:new Text('GridView'),
        ),
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:new Text('GridView'),
        ),
        new Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:new Text('GridView'),
        ),
      ],
    ),
  );
}
