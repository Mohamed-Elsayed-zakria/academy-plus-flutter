import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/skeleton_loader.dart';
import '../../../../../core/widgets/skeleton_sub_department_grid.dart';
import '../../../../../core/utils/navigation_helper.dart';
import '../../../data/models/department_model.dart';
import '../../../data/models/sub_department_model.dart';
import '../../../data/repository/sub_department_implement.dart';
import '../../manager/cubit/sub_department_cubit.dart';
import '../../manager/cubit/sub_department_state.dart';

class SubDepartmentsScreen extends StatefulWidget {
  final DepartmentModel department;

  const SubDepartmentsScreen({
    super.key,
    required this.department,
  });

  @override
  State<SubDepartmentsScreen> createState() => _SubDepartmentsScreenState();
}

class _SubDepartmentsScreenState extends State<SubDepartmentsScreen> {
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
        SliverToBoxAdapter(
          child: SkeletonSubDepartmentGrid(itemCount: 6),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubDepartmentCubit(SubDepartmentImplement())
        ..getSubDepartmentsByDepartment(widget.department.id),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            widget.department.nameAr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
        body: BlocBuilder<SubDepartmentCubit, SubDepartmentState>(
          builder: (context, state) {
            if (state is SubDepartmentLoading) {
              return _buildLoadingState();
            } else if (state is SubDepartmentError) {
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
                        context.read<SubDepartmentCubit>().getSubDepartmentsByDepartment(widget.department.id);
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            } else if (state is SubDepartmentLoaded) {
              return _buildSubDepartmentsList(state.subDepartments);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSubDepartmentsList(List<SubDepartmentModel> subDepartments) {
    // Filter sub departments based on search
    List<SubDepartmentModel> filteredList = subDepartments;
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filteredList = subDepartments.where((subDept) {
        return subDept.nameAr.toLowerCase().contains(query) ||
               subDept.nameEn.toLowerCase().contains(query);
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
              hintText: 'البحث في الأقسام الفرعية...',
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
                'تم العثور على ${filteredList.length} قسم فرعي',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
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
                          : 'لا توجد أقسام فرعية',
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
                          : 'سيتم إضافة الأقسام الفرعية قريباً',
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
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final subDepartment = filteredList[index];
                  return _buildSubDepartmentCard(subDepartment);
                },
                childCount: filteredList.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSubDepartmentCard(SubDepartmentModel subDepartment) {
    return InkWell(
      onTap: () {
        NavigationHelper.to(
          path: '/subdepartment/${subDepartment.id}/courses',
          context: context,
          data: subDepartment,
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
                      subDepartment.logo,
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
                                value: loadingProgress.expectedTotalBytes != null
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
                      subDepartment.nameAr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Ionicons.book_outline,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${subDepartment.coursesCount} مادة',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
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