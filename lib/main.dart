import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();
    const url = 'https://www.youtube.com/watch?v=8Z80gMnALqU';

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: YoutubePlayerFlags(mute: false))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: YoutubePlayerBuilder(
        builder: (context, player) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text('Youtube Player'),
          ),
          body: ListView(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (controller.value.isPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    },
                    child: Text(controller.value.isPlaying ? 'Pause' : 'Play')),
              )
            ],
          ),
        ),
        player: YoutubePlayer(controller: controller),
      ),
    );
  }
}
