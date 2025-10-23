import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/skeleton_loader.dart';
import '../../../../../core/widgets/skeleton_course_grid.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../home/data/models/sub_department_model.dart';
import '../../data/models/course_model.dart';
import '../../data/repository/course_implement.dart';
import '../manager/course_cubit.dart';
import '../manager/course_state.dart';

class CoursesScreen extends StatefulWidget {
  final SubDepartmentModel subDepartment;

  const CoursesScreen({super.key, required this.subDepartment});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      // Search functionality will be handled in the build method
    });
  }

  Widget _buildLoadingState() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Search Bar Skeleton
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SkeletonLoader(
              height: 50,
              width: double.infinity,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Grid Skeleton
        SliverToBoxAdapter(child: SkeletonCourseGrid(itemCount: 6)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseCubit(CourseImplement())
            ..getCoursesBySubDepartment(widget.subDepartment.id),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            widget.subDepartment.nameAr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
        body: BlocListener<CourseCubit, CourseState>(
          listener: (context, state) {
            // Handle cart-related states
            if (state is CourseAddedToCart) {
              CustomToast.showSuccess(context, message: state.message);
            } else if (state is CourseCartError) {
              CustomToast.showError(context, message: state.error);
            }
          },
          child: BlocBuilder<CourseCubit, CourseState>(
            builder: (context, state) {
              if (state is CourseLoading) {
                return _buildLoadingState();
              } else if (state is CourseError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.alert_circle_outline,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.error,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CourseCubit>().getCoursesBySubDepartment(
                            widget.subDepartment.id,
                          );
                        },
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              } else if (state is CourseLoaded || 
                         state is CourseAddingToCart || 
                         state is CourseAddedToCart || 
                         state is CourseCartError) {
                // Get courses from any of these states
                List<CourseModel> courses = [];
                if (state is CourseLoaded) {
                  courses = state.courses;
                } else if (state is CourseAddingToCart) {
                  courses = state.courses;
                } else if (state is CourseAddedToCart) {
                  courses = state.courses;
                } else if (state is CourseCartError) {
                  courses = state.courses;
                }
                return _buildCoursesList(courses, state);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesList(List<CourseModel> courses, CourseState state) {
    // Filter courses based on search
    List<CourseModel> filteredList = courses;
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredList = courses.where((course) {
        return course.titleAr.toLowerCase().contains(query) ||
            course.titleEn.toLowerCase().contains(query) ||
            course.instructorName.toLowerCase().contains(query);
      }).toList();
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              controller: _searchController,
              hintText: 'البحث في المواد...',
              prefixIcon: const Icon(
                Ionicons.search_outline,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
          ),
        ),

        // Results count
        if (_searchController.text.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'تم العثور على ${filteredList.length} مادة',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            ),
          ),

        // Grid or Empty State
        if (filteredList.isEmpty)
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/undraw_no-data_ig65.svg',
                      width: 160,
                      height: 160,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _searchController.text.isNotEmpty
                          ? 'لا توجد نتائج للبحث'
                          : 'لا توجد مواد متاحة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _searchController.text.isNotEmpty
                          ? 'جرب البحث بكلمات مختلفة'
                          : 'سيتم إضافة المواد قريباً',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final course = filteredList[index];
                return _buildCourseCard(course, state, context.read<CourseCubit>());
              }, childCount: filteredList.length),
            ),
          ),
      ],
    );
  }

  Widget _buildCourseCard(CourseModel course, CourseState state, CourseCubit cubit) {
    return InkWell(
      onTap: () {
        // Navigate to course details
        NavigationHelper.to(
          path: '/course/${course.id}',
          context: context,
          data: course,
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      course.coverImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary.withValues(alpha: 0.7),
                                AppColors.primary.withValues(alpha: 0.5),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Ionicons.book_outline,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.surfaceGrey,
                          child: Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                    // Price badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          course.discountPrice > 0
                              ? '${course.discountPrice.toStringAsFixed(0)} ج.م'
                              : '${course.price.toStringAsFixed(0)} ج.م',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Cart icon
                    Positioned(
                      top: 8,
                      left: 8,
                      child: GestureDetector(
                        onTap: () => cubit.addCourseToCart(course),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: (state is CourseAddingToCart && 
                                  state.courseId == course.id)
                              ? SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primary,
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Ionicons.cart_outline,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      course.titleAr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.instructorName,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Ionicons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        if (course.discountPrice > 0)
                          Text(
                            '${course.price.toStringAsFixed(0)} ج.م',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
