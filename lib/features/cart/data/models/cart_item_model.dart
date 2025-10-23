class CartItemModel {
  final String id;
  final String cartId;
  final String itemType;
  final String? courseId;
  final String? assignmentId;
  final String? quizId;
  final double price;
  final double? discountPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CourseModel? courses;
  final AssignmentModel? assignments;
  final QuizModel? quizzes;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.itemType,
    this.courseId,
    this.assignmentId,
    this.quizId,
    required this.price,
    this.discountPrice,
    required this.createdAt,
    required this.updatedAt,
    this.courses,
    this.assignments,
    this.quizzes,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? '',
      cartId: json['cart_id'] ?? '',
      itemType: json['item_type'] ?? '',
      courseId: json['course_id'],
      assignmentId: json['assignment_id'],
      quizId: json['quiz_id'],
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: json['discount_price']?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      courses: json['courses'] != null ? CourseModel.fromJson(json['courses']) : null,
      assignments: json['assignments'] != null ? AssignmentModel.fromJson(json['assignments']) : null,
      quizzes: json['quizzes'] != null ? QuizModel.fromJson(json['quizzes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart_id': cartId,
      'item_type': itemType,
      'course_id': courseId,
      'assignment_id': assignmentId,
      'quiz_id': quizId,
      'price': price,
      'discount_price': discountPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'courses': courses?.toJson(),
      'assignments': assignments?.toJson(),
      'quizzes': quizzes?.toJson(),
    };
  }

  // Helper methods
  String get title {
    switch (itemType) {
      case 'course':
        return courses?.titleAr ?? courses?.titleEn ?? '';
      case 'assignment':
        return assignments?.titleAr ?? assignments?.titleEn ?? '';
      case 'quiz':
        return quizzes?.titleAr ?? quizzes?.titleEn ?? '';
      default:
        return '';
    }
  }

  String get titleEn {
    switch (itemType) {
      case 'course':
        return courses?.titleEn ?? '';
      case 'assignment':
        return assignments?.titleEn ?? '';
      case 'quiz':
        return quizzes?.titleEn ?? '';
      default:
        return '';
    }
  }

  String get instructor {
    switch (itemType) {
      case 'course':
        return courses?.instructorName ?? '';
      case 'assignment':
        return 'Assignment';
      case 'quiz':
        return 'Quiz';
      default:
        return '';
    }
  }

  String? get imageUrl {
    switch (itemType) {
      case 'course':
        return courses?.coverImage;
      case 'assignment':
        return null;
      case 'quiz':
        return null;
      default:
        return null;
    }
  }

  double get finalPrice {
    return discountPrice ?? price;
  }

  double get discountAmount {
    if (discountPrice != null) {
      return price - discountPrice!;
    }
    return 0.0;
  }

  double get discountPercentage {
    if (discountPrice != null && price > 0) {
      return ((price - discountPrice!) / price) * 100;
    }
    return 0.0;
  }
}

class CourseModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String? coverImage;
  final String? instructorName;

  CourseModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    this.coverImage,
    this.instructorName,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      titleAr: json['title_ar'] ?? '',
      titleEn: json['title_en'] ?? '',
      coverImage: json['cover_image'],
      instructorName: json['instructor_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ar': titleAr,
      'title_en': titleEn,
      'cover_image': coverImage,
      'instructor_name': instructorName,
    };
  }
}

class AssignmentModel {
  final String id;
  final DateTime? dueDate;
  final String titleAr;
  final String titleEn;

  AssignmentModel({
    required this.id,
    this.dueDate,
    required this.titleAr,
    required this.titleEn,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] ?? '',
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      titleAr: json['title_ar'] ?? '',
      titleEn: json['title_en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'due_date': dueDate?.toIso8601String(),
      'title_ar': titleAr,
      'title_en': titleEn,
    };
  }
}

class QuizModel {
  final String id;
  final String status;
  final String titleAr;
  final String titleEn;

  QuizModel({
    required this.id,
    required this.status,
    required this.titleAr,
    required this.titleEn,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      titleAr: json['title_ar'] ?? '',
      titleEn: json['title_en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'title_ar': titleAr,
      'title_en': titleEn,
    };
  }
}
