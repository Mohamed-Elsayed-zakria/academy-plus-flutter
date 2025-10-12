import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';

class SubDepartmentsScreen extends StatefulWidget {
  final Map<String, dynamic> department;

  const SubDepartmentsScreen({
    super.key,
    required this.department,
  });

  @override
  State<SubDepartmentsScreen> createState() => _SubDepartmentsScreenState();
}

class _SubDepartmentsScreenState extends State<SubDepartmentsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Animation<double>> _animations = [];

  // Icons for each sub-department (you can customize these)
  final Map<String, IconData> _subDepartmentIcons = {
    // Business sub-departments
    'Accounting': Icons.account_balance,
    'Marketing': Icons.campaign,
    'Finance': Icons.attach_money,
    'HR': Icons.people,
    // Engineering sub-departments
    'Computer Science': Icons.computer,
    'Electrical': Icons.electrical_services,
    'Mechanical': Icons.precision_manufacturing,
    'Civil': Icons.construction,
    // Medicine sub-departments
    'General Medicine': Icons.medical_services,
    'Surgery': Icons.local_hospital,
    'Pediatrics': Icons.child_care,
    'Cardiology': Icons.favorite,
    // Arts sub-departments
    'Fine Arts': Icons.brush,
    'Music': Icons.music_note,
    'Theater': Icons.theater_comedy,
    'Literature': Icons.menu_book,
    // Science sub-departments
    'Physics': Icons.science,
    'Chemistry': Icons.biotech,
    'Biology': Icons.eco,
    'Mathematics': Icons.calculate,
    // Law sub-departments
    'Criminal Law': Icons.gavel,
    'Civil Law': Icons.balance,
    'International Law': Icons.public,
    'Corporate Law': Icons.business,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final subDepartments = widget.department['subDepartments'] as List<dynamic>;
    for (int i = 0; i < subDepartments.length; i++) {
      final delay = i * 0.1;
      _animations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              delay,
              delay + 0.5,
              curve: Curves.easeOutCubic,
            ),
          ),
        ),
      );
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData _getIconForSubDepartment(String subDepartmentName) {
    return _subDepartmentIcons[subDepartmentName] ?? Icons.school;
  }

  @override
  Widget build(BuildContext context) {
    final subDepartments = widget.department['subDepartments'] as List<dynamic>;
    final departmentColor = widget.department['color'] as Color;
    final departmentIcon = widget.department['icon'] as IconData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with gradient
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.department['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      departmentColor,
                      departmentColor.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    // Department Icon
                    Center(
                      child: Icon(
                        departmentIcon,
                        size: 80,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Sub-departments header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Specialization',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${subDepartments.length} specializations available',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),

          // Sub-departments grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final subDepartment = subDepartments[index] as String;
                  final icon = _getIconForSubDepartment(subDepartment);

                  return AnimatedBuilder(
                    animation: _animations[index],
                    builder: (context, child) {
                      final animValue = _animations[index].value;
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - animValue)),
                        child: Opacity(
                          opacity: animValue,
                          child: child,
                        ),
                      );
                    },
                    child: _SubDepartmentCard(
                      title: subDepartment,
                      icon: icon,
                      color: departmentColor,
                      onTap: () {
                        context.push(
                          '/subdepartment/${widget.department['id']}/$index/courses',
                          extra: {
                            'departmentName': widget.department['name'],
                            'subDepartmentName': subDepartment,
                            'color': departmentColor,
                          },
                        );
                      },
                    ),
                  );
                },
                childCount: subDepartments.length,
              ),
            ),
          ),

          // Bottom spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }
}

class _SubDepartmentCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SubDepartmentCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_SubDepartmentCard> createState() => _SubDepartmentCardState();
}

class _SubDepartmentCardState extends State<_SubDepartmentCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Gradient background
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.color.withValues(alpha: 0.15),
                          widget.color.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon container
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.color,
                          size: 32,
                        ),
                      ),

                      const Spacer(),

                      // Title
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Arrow indicator
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: widget.color,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
