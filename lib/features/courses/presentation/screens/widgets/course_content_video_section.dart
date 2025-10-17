import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../data/models/course_model.dart';

class CourseContentVideoSection extends StatefulWidget {
  final CourseModel course;
  const CourseContentVideoSection({super.key, required this.course});
  @override
  State<CourseContentVideoSection> createState() =>
      _CourseContentVideoSectionState();
}

class _CourseContentVideoSectionState extends State<CourseContentVideoSection> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (widget.course.introVideo.isNotEmpty) {
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.course.introVideo),
        );
        await _videoPlayerController!.initialize();
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: false,
          looping: false,
          allowFullScreen: true,
          allowMuting: true,
          showOptions: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: AppColors.primary,
            handleColor: AppColors.primary,
            backgroundColor: AppColors.surfaceGrey,
            bufferedColor: AppColors.surfaceGrey.withValues(alpha: 0.5),
          ),
          placeholder: Container(
            height: 250,
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
          autoInitialize: true,
        );
        if (mounted) {
          setState(() {
            _isInitialized = true;
            _hasError = false;
          });
        }
      } else {
        setState(() {
          _hasError = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: _buildVideoContent(),
    );
  }

  Widget _buildVideoContent() {
    if (_hasError || widget.course.introVideo.isEmpty) {
      return _buildErrorState();
    }
    if (!_isInitialized || _chewieController == null) {
      return _buildLoadingState();
    }
    return Chewie(controller: _chewieController!);
  }

  Widget _buildLoadingState() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  'جاري تحميل الفيديو...',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.course.introVideo.isEmpty
                      ? 'لا يوجد فيديو متاح'
                      : 'فشل في تحميل الفيديو',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                if (widget.course.introVideo.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = false;
                        _isInitialized = false;
                      });
                      _initializeVideo();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ],
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              AppLocalizations.freePreview,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}