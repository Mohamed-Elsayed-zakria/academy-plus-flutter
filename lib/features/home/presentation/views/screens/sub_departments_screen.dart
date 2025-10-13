import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';

class SubDepartmentsScreen extends StatelessWidget {
  final Map<String, dynamic> department;

  const SubDepartmentsScreen({
    super.key,
    required this.department,
  });

  String _getSubDepartmentImage(String subDeptName) {
    // Return different images based on sub-department name
    switch (subDeptName) {
      case 'المحاسبة':
        return 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=500&h=300&fit=crop';
      case 'التسويق':
        return 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=500&h=300&fit=crop';
      case 'التمويل':
        return 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=500&h=300&fit=crop';
      case 'الموارد البشرية':
        return 'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=500&h=300&fit=crop';
      case 'علوم الحاسوب':
        return 'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=500&h=300&fit=crop';
      case 'الهندسة الكهربائية':
        return 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=500&h=300&fit=crop';
      case 'الهندسة الميكانيكية':
        return 'https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=500&h=300&fit=crop';
      case 'الهندسة المدنية':
        return 'https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=500&h=300&fit=crop';
      case 'الطب العام':
        return 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=500&h=300&fit=crop';
      case 'الجراحة':
        return 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=500&h=300&fit=crop';
      case 'طب الأطفال':
        return 'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=500&h=300&fit=crop';
      case 'أمراض القلب':
        return 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=500&h=300&fit=crop';
      case 'الفنون الجميلة':
        return 'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=500&h=300&fit=crop';
      case 'الموسيقى':
        return 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=500&h=300&fit=crop';
      case 'المسرح':
        return 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=300&fit=crop';
      case 'الأدب':
        return 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=500&h=300&fit=crop';
      case 'الفيزياء':
        return 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=500&h=300&fit=crop';
      case 'الكيمياء':
        return 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=500&h=300&fit=crop';
      case 'الأحياء':
        return 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=500&h=300&fit=crop';
      case 'الرياضيات':
        return 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=500&h=300&fit=crop';
      case 'القانون الجنائي':
        return 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=500&h=300&fit=crop';
      case 'القانون المدني':
        return 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=500&h=300&fit=crop';
      case 'القانون الدولي':
        return 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=500&h=300&fit=crop';
      case 'قانون الشركات':
        return 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=500&h=300&fit=crop';
      default:
        return 'https://ans.edu.jo/uploads/2024/09/66eaa687e6465.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final subDepartments = department['subDepartments'] as List;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(department['name'] as String),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
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
                  final subDept = subDepartments[index];
                  
                  return InkWell(
                    onTap: () {
                      context.push(
                        '/subdepartment/${department['id']}/$index/courses',
                        extra: {
                          'subDepartmentName': subDept,
                          'subDepartmentId': index,
                          'departmentId': department['id'],
                          'departmentName': department['name'],
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
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
                                    _getSubDepartmentImage(subDept),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              AppColors.primary.withOpacity(0.7),
                                              AppColors.primary.withOpacity(0.5),
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
                                          Colors.black.withOpacity(0.3),
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
                                    subDept as String,
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
                                        '12 مادة',
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
                },
                childCount: subDepartments.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
