// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class TrainingVideo extends StatefulWidget {
//   final String videoUrl;
//
//   TrainingVideo({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   _TrainingVideoState createState() => _TrainingVideoState();
// }
//
// class _TrainingVideoState extends State<TrainingVideo> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl);
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }
