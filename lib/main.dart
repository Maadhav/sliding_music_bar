import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(SlidingUpPanelExample());

class SlidingUpPanelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _panelHeightOpen;
  double _panelHeightClosed = 95.0;
  PanelController _controller = PanelController();
  double _slider = 0.3;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height;
    return Material(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: Container(
            height: 54.00,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, -8.00),
                  color: Color(0xff007084).withOpacity(0.03),
                  blurRadius: 13,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.note_add),
                Icon(Icons.book),
                Icon(Icons.person),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: false,
            // parallaxOffset: .5,
            collapsed: Opacity(
              // duration: Duration(milliseconds: 500),
              opacity: 1,
              // opacity: _controller??_controller.panelPosition<0.05?1:0,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 100.0 ),
                  child: Row(
                    children: [
                      Expanded(
                          child: ListTile(
                        title: Text(
                          // this.widget.title,
                          "Audio Title",
                          style: TextStyle(
                            fontFamily: "Circular Std",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            // color: widget.color,
                          ),
                        ),
                        subtitle: Text(
                          // this.widget.subtitle,
                          "Audio SubTitle",
                          style: TextStyle(
                            fontFamily: "Circular Std",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            // color: widget.color,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 34,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.skip_next,
                              color: Colors.black,
                              size: 34,
                            ),
                          ],
                        ),
                      ))
                    ],
                  )),
            ),
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            controller: _controller,
            onPanelSlide: (s) {
              print(s);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return ListView(
      padding: EdgeInsets.zero,
      controller: sc,
      children: [
        SizedBox(
          height: _controller.panelPosition * 60,
        ),
        Align(
          alignment: Alignment(
              _controller.panelPosition - 1, _controller.panelPosition - 1),
          child: SizedBox(
            height: _controller.panelPosition * 200 + 100,
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/en/thumb/3/3e/Themusic.themusic.albumcover.jpg/220px-Themusic.themusic.albumcover.jpg",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Opacity(
          // duration: Duration(milliseconds: 800),
          opacity: _controller.panelPosition,
          child: Column(
            children: [
              Text(
                // this.widget.title,
                "Audio Title",
                style: TextStyle(
                  fontFamily: "Circular Std",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  // color: widget.color,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                // this.widget.subtitle,
                "Audio SubTitle",
                style: TextStyle(
                  fontFamily: "Circular Std",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  // color: widget.color,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _controller.panelPosition,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Slider(
                    value: _slider ?? 0,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _slider = value;
                      });
                    },
                    onChangeEnd: (value) {
                      // if (_duration != null) {
                      //   Duration msec = Duration(
                      //       milliseconds:
                      //           (_duration.inMilliseconds * value).round());
                      //   AudioManager.instance.seekTo(msec);
                      // }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 49),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // _formatDuration(_position),
                      "15:12",
                      style: TextStyle(
                        fontFamily: "Circular Std",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        // color: widget.color,
                      ),
                    ),
                    Text(
                      // _formatDuration(_duration),
                      "43:09",
                      style: TextStyle(
                        fontFamily: "Circular Std",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        // color: widget.color,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(Icons.slideshow), onPressed: () {})),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                        icon: Icon(Icons.skip_previous), onPressed: () {}),
                    Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () async {
                          // bool playing =
                          //     await AudioManager.instance.playOrPause();
                          // print("await -- $playing");
                        },
                        splashColor: Colors.white.withOpacity(0.3),
                        child: Icon(Icons.play_arrow, size: 60),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
                    SizedBox(
                      width: 30,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          icon: Icon(Icons.slow_motion_video), onPressed: () {}
                          // AudioManager.instance.previous()),
                          ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
    );
  }
}
