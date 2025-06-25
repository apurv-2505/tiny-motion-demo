import 'dart:io';
import 'package:demo_app/screens/submission_screen.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoReviewScreen extends StatefulWidget {
  final String videoPath;
  final bool isValidLength;

  const VideoReviewScreen({
    super.key,
    required this.videoPath,
    required this.isValidLength,
  });

  @override
  State<VideoReviewScreen> createState() => _VideoReviewScreenState();
}

class _VideoReviewScreenState extends State<VideoReviewScreen> {
  VideoPlayerController? _videoController;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.file(File(widget.videoPath));
      await _videoController!.initialize();

      _videoController!.addListener(() {
        if (mounted) setState(() {});
      });

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      _showErrorDialog('Failed to load video');
    }
  }

  void _togglePlayPause() {
    if (_videoController!.value.isPlaying) {
      _videoController!.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      _videoController!.play();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _retakeVideo() {
    Navigator.pop(context);
  }

  void _proceedToNext() {
    if (!widget.isValidLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video is longer than 2 minutes, please take the video again!',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SubmissionScreen(videoPath: widget.videoPath),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Recording'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: _isInitialized
          ? Column(
              children: [
                // Video player
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: Stack(
                        children: [
                          VideoPlayer(_videoController!),

                          // Play/pause overlay
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: _togglePlayPause,
                              child: Container(
                                color: Colors.transparent,
                                child: _isPlaying
                                    ? SizedBox.shrink()
                                    : Center(
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(
                                              alpha: 0.7,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Video controls
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Video progress bar
                      VideoProgressIndicator(
                        _videoController!,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: Colors.blue,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.grey[300]!,
                        ),
                      ),

                      SizedBox(height: 8),

                      // Time display
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_videoController!.value.position),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _formatDuration(_videoController!.value.duration),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      // Control buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _togglePlayPause,
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            label: Text(_isPlaying ? 'Pause' : 'Play'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _retakeVideo,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.white),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text('Retake Video'),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _proceedToNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text('Continue'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
