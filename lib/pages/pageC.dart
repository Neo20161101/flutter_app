import 'package:flutter/material.dart';

class PageC extends StatelessWidget {
  PageC({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('pageC'),
        ),
        body: ListView(
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

  Widget titleSection = Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
//      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: const FlutterLogoDecoration(textColor:Color(0x00ffffff)),
              height: 50,
              child: const Text('Around'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: 50,
              child: const Text('Around'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: 50,
              child: const Text('Around'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: 50,
              child: const Text('Around'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: 50,
              child: const Text('Around'),
            )
          ],
        ),
      ],
    ),
  );

  Widget contentSection = Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(255, 119, 0, 1)),
              ),
              child: const Text('Evenly'),
            )
          ],
        ),
        const Column(
          children: <Widget>[
            Text('Evenly')
          ],
        ),
        const Column(
          children: <Widget>[
            Text('Evenly')
          ],
        ),
        const Column(
          children: <Widget>[
            Text('Evenly')
          ],
        ),
        const Column(
          children: <Widget>[
            Text('Evenly')
          ],
        ),
      ],
    ),
  );
  Widget contentSection1 = Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
              ),
              child: Text('Between'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('Between'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('Between'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('Between'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('Between'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection2 = Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child: Text('Expanded'),
        )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text('Expanded'),
              ),
              Container(
                child: Text('Expanded'),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Text('Expanded'),
          ),
        ),
        Expanded(
          child: Container(
            child: Text('Expanded'),
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child: Text('Expanded'),
        )),
      ],
    ),
  );
  Widget contentSection3 = Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Text('start2start2start2start2'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('start2'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('start2'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('start2'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('start2'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection4 = Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Text('end3'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('end3'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('end3'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('end3'),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Text('end3'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection5 = Container(
    padding: const EdgeInsets.only(top: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text('spaceBetween'),
            )
          ],
        ),
        Column(
//          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text('spaceBetween4'),
            )
          ],
        ),
      ],
    ),
  );
  Widget contentSection6(context) => Container(
    padding: const EdgeInsets.only(top: 32.0),
    height: 300,
    child: GridView.extent(
      maxCrossAxisExtent: 80,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          height: 100,
          child:Text('GridView'),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:Text('GridView'),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:Text('GridView'),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:Text('GridView'),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:Text('GridView'),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:Text('GridView'),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:Text('GridView'),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 119, 0, 1)),
          ),
          child:Text('GridView'),
        ),
      ],
    ),
  );
}
