import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// ignore: must_be_immutable
class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState(){
    super.initState();
    getInstance();
  }
  void getInstance() async{
    var box = await Hive.openBox('idYoutubeBox');
     setState(() {
       id=box.get('idYoutube');
     });
  }

  static String id;
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId:id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute:false,)
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar:true,
        appBar:AppBar(
          backgroundColor:Colors.black,
        ),
        backgroundColor:Colors.black,
        body:Center(
        child: Container(
        child:YoutubePlayer(
          onEnded:(s){
            Navigator.pop(context);
          },
          liveUIColor:Colors.red,
        controller: _controller,
    ),
    ),
    ));
  }
}

