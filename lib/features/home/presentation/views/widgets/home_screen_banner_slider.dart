import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreenBannerSlider extends StatefulWidget {
  const HomeScreenBannerSlider({super.key});

  @override
  State<HomeScreenBannerSlider> createState() => _HomeScreenBannerSliderState();
}

class _HomeScreenBannerSliderState extends State<HomeScreenBannerSlider>
    with TickerProviderStateMixin {
  int _currentSlide = 0;
  late Animation<double> _shimmerAnimation;
  late AnimationController _shimmerController;

  final List<String> _bannersUrls = [
    'https://talaeaalghad.edu.sa/wp-content/uploads/2023/06/66bbfa3d80600cd36191c46fa7983b7e-scaled.jpg',
    'https://ia-bc.com/wp-content/uploads/2024/01/School-Science-Laboratory.jpg',
    'https://ans.edu.jo/uploads/2024/09/66eaa687e6465.jpg',
    'https://ans.edu.jo/uploads/2023/09/64f6c5a88eba4.jpg',
    'https://ans.edu.jo/uploads/2023/08/64e709d3c69fe.jpg',
    'https://ans.edu.jo/uploads/2019/09/5d7f60e877963.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlide = index;
              });
            },
          ),
          items: _bannersUrls.map((bannerUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      bannerUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return AnimatedBuilder(
                          animation: _shimmerAnimation,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.surfaceGrey.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Shimmer effect
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.transparent,
                                            Colors.white.withValues(alpha: 0.4),
                                            Colors.transparent,
                                          ],
                                          stops: [
                                            _shimmerAnimation.value - 0.3,
                                            _shimmerAnimation.value,
                                            _shimmerAnimation.value + 0.3,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: AppColors.primaryGradient,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.image_outline,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Failed to load image',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),

        // Fixed Carousel Indicators
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _bannersUrls.asMap().entries.map((entry) {
            return Container(
              width: _currentSlide == entry.key ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentSlide == entry.key
                    ? AppColors.primary
                    : AppColors.textTertiary.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
