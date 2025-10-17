import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_banner_slider.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_quick_access_section.dart';
import 'package:university/features/home/presentation/views/widgets/home_screen_search_bar.dart';
import 'package:university/features/home/presentation/views/widgets/departments_grid_widget.dart';
import 'package:university/features/home/presentation/views/widgets/ad_skeleton_loader.dart';
import 'package:university/features/home/presentation/views/widgets/department_skeleton_loader.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/services/auth_manager.dart';
import '../../../data/repository/ad_implement.dart';
import '../../../data/repository/department_implement.dart';
import '../../manager/cubit/ad_cubit.dart';
import '../../manager/cubit/ad_state.dart';
import '../../manager/cubit/department_cubit.dart';
import '../../manager/cubit/department_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdCubit(AdImplement())..getAllAds()),
        BlocProvider(create: (context) => DepartmentCubit(DepartmentImplement())),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(AppLocalizations.appName),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Ionicons.heart_outline),
              tooltip: 'Favorites',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Search Bar
            SliverToBoxAdapter(child: HomeScreenSearchBar()),
            // Ads Section
            BlocBuilder<AdCubit, AdState>(
              builder: (context, state) {
                if (state is AdLoading) {
                  return SliverToBoxAdapter(
                    child: AdSkeletonLoader(),
                  );
                } else if (state is AdLoaded && state.ads.isNotEmpty) {
                  return SliverToBoxAdapter(
                    child: HomeScreenBannerSlider(
                      bannersUrls: state.ads.map((ad) => ad.imageUrl).toList(),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),

            // Quick Access Section
            SliverToBoxAdapter(child: HomeScreenQuickAccessSection()),

            SliverToBoxAdapter(child: const SizedBox(height: 24)),

            // Departments Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.departments,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            // Departments Grid
            BlocBuilder<DepartmentCubit, DepartmentState>(
              builder: (context, state) {
                if (state is DepartmentLoading) {
                  return const SliverToBoxAdapter(
                    child: DepartmentSkeletonGrid(itemCount: 4),
                  );
                } else if (state is DepartmentError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              Ionicons.alert_circle_outline,
                              size: 48,
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
                                final universityId = AuthManager.universityId;
                                if (universityId != null) {
                                  context.read<DepartmentCubit>().getDepartmentsByUniversity(universityId);
                                } else {
                                  context.read<DepartmentCubit>().getAllDepartments();
                                }
                              },
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is DepartmentLoaded) {
                  return SliverToBoxAdapter(
                    child: DepartmentsGridWidget(departments: state.departments),
                  );
                } else {
                  // Initial state - load departments
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final universityId = AuthManager.universityId;
                    if (universityId != null) {
                      context.read<DepartmentCubit>().getDepartmentsByUniversity(universityId);
                    } else {
                      context.read<DepartmentCubit>().getAllDepartments();
                    }
                  });
                  return const SliverToBoxAdapter(
                    child: DepartmentSkeletonGrid(itemCount: 4),
                  );
                }
              },
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
