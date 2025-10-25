# تحديث نظام الكوبونات في صفحة السلة

## التحديثات المنجزة

### 1. إنشاء نماذج البيانات (Models)
- **CouponModel**: نموذج بيانات الكوبون مع جميع الخصائص المطلوبة
- **CouponValidationResponse**: نموذج استجابة التحقق من الكوبون

### 2. إنشاء خدمات API
- **CouponRepo**: واجهة خدمة الكوبونات
- **CouponImplement**: تطبيق خدمة الكوبونات مع API calls

### 3. تحديث API Endpoints
- إضافة `/api/coupons/validate` إلى قائمة endpoints

### 4. تحديث Service Locator
- تسجيل CouponRepo في dependency injection

### 5. تحديث صفحة السلة
- استبدال الكوبونات الوهمية بـ API calls حقيقية
- إضافة حالة التحميل أثناء التحقق من الكوبون
- تحسين معالجة الأخطاء
- تحديث عرض بيانات الكوبون المطبق

## كيفية العمل

### عند كتابة كود الكوبون والضغط على "تحقق":
1. يتم استدعاء API: `GET /api/coupons/validate/{couponCode}`
2. يتم عرض حالة التحميل أثناء الانتظار
3. عند نجاح الاستجابة:
   - يتم حفظ بيانات الكوبون
   - يتم عرض رسالة نجاح
   - يتم تحديث حساب الخصم
4. عند فشل الاستجابة:
   - يتم عرض رسالة خطأ من API

### أنواع الخصم المدعومة:
- **نسبة مئوية**: خصم بنسبة معينة من المجموع الفرعي
- **مبلغ ثابت**: خصم بمبلغ محدد

### معالجة الأخطاء:
- رسائل خطأ باللغة العربية والإنجليزية
- عرض رسائل واضحة للمستخدم
- منع إدخال كوبونات غير صحيحة

## الملفات المحدثة:
- `lib/features/cart/data/models/coupon_model.dart`
- `lib/features/cart/data/models/coupon_validation_response.dart`
- `lib/features/cart/data/repository/coupon_repo.dart`
- `lib/features/cart/data/repository/coupon_implement.dart`
- `lib/core/constants/api_end_point.dart`
- `lib/core/services/service_locator.dart`
- `lib/features/cart/presentation/screens/cart_screen.dart`

## مثال على الاستخدام:
```dart
// في cart_screen.dart
final result = await _couponRepo.validateCoupon(couponCode);
result.fold(
  (failure) => CustomToast.showError(context, message: failure.errMessage),
  (validationResponse) {
    if (validationResponse.success && validationResponse.data?.valid == true) {
      // تطبيق الكوبون بنجاح
      setState(() {
        _appliedCoupon = validationResponse.data!.coupon!;
        _isCouponApplied = true;
      });
    }
  },
);
```
