# تنظيم صفحة السلة باستخدام Cubit و Widgets منفصلة

## التحديثات المنجزة

### 1. إنشاء CartCubit
- **CartState**: جميع حالات السلة (Loading, Loaded, Error, Empty, CouponValidating, CouponApplied, CouponRemoved)
- **CartCubit**: إدارة حالة السلة مع جميع العمليات المطلوبة
- **دوال مساعدة**: getCurrentCartItems(), getCurrentCoupon(), getCurrentCouponCode(), getCurrentCouponApplied()
- **حساب المجاميع**: originalTotal, discountAmount, subtotal, couponDiscountAmount, total

### 2. تقسيم Widgets إلى ملفات منفصلة
- **CartHeaderWidget**: شريط العنوان مع زر مسح السلة
- **CartLoadingWidget**: حالة التحميل
- **CartErrorWidget**: حالة الخطأ مع زر إعادة المحاولة
- **CartEmptyWidget**: السلة الفارغة مع رسالة تشجيعية
- **CartItemsListWidget**: قائمة عناصر السلة مع RefreshIndicator
- **CartItemWidget**: عنصر واحد في السلة مع تفاصيله
- **CartCouponSectionWidget**: قسم الكوبونات مع التحقق من API
- **CartCheckoutSectionWidget**: قسم الدفع مع حساب المجاميع
- **CartFloatingButtonWidget**: زر الدفع العائم

### 3. تحديث CartScreen
- استخدام BlocProvider و BlocBuilder
- تنظيم الكود بشكل أفضل
- فصل الاهتمامات (Separation of Concerns)
- استخدام widgets منفصلة

### 4. إضافة إلى Service Locator
- تسجيل CartCubit في dependency injection

## بنية الملفات الجديدة

```
lib/features/cart/presentation/
├── manager/
│   └── cart_cubit/
│       ├── cart_cubit.dart
│       └── cart_state.dart
├── views/
│   └── widgets/
│       ├── cart_screen/
│       │   ├── cart_screen_widgets.dart
│       │   ├── cart_header_widget.dart
│       │   ├── cart_loading_widget.dart
│       │   ├── cart_error_widget.dart
│       │   ├── cart_empty_widget.dart
│       │   ├── cart_items_list_widget.dart
│       │   ├── cart_item_widget.dart
│       │   ├── cart_coupon_section_widget.dart
│       │   ├── cart_checkout_section_widget.dart
│       │   └── cart_floating_button_widget.dart
│       └── empty_cart_illustration.dart
└── screens/
    └── cart_screen.dart
```

## المميزات الجديدة

### 1. إدارة الحالة المتقدمة
- حالات منفصلة لكل عملية
- حفظ حالة الكوبونات عبر جميع الحالات
- معالجة أخطاء شاملة

### 2. تنظيم الكود
- كل widget في ملف منفصل
- مسؤوليات واضحة لكل مكون
- سهولة الصيانة والتطوير

### 3. إعادة الاستخدام
- يمكن استخدام widgets في صفحات أخرى
- cubit يمكن استخدامه في صفحات متعددة
- فصل منطق الأعمال عن العرض

### 4. اختبار أفضل
- يمكن اختبار كل widget منفصل
- يمكن اختبار cubit بشكل منفصل
- سهولة كتابة unit tests

## كيفية الاستخدام

### في صفحة أخرى:
```dart
BlocProvider(
  create: (context) => SetupLocator.locator<CartCubit>(),
  child: BlocBuilder<CartCubit, CartState>(
    builder: (context, state) {
      // استخدام widgets منفصلة
      return CartItemsListWidget(
        cartItems: cartCubit.getCurrentCartItems(),
        onRefresh: () => cartCubit.refreshCartItems(),
        onRemoveItem: (id) => cartCubit.removeItemFromCart(id, context),
      );
    },
  ),
)
```

### الوصول إلى البيانات:
```dart
final cartCubit = context.read<CartCubit>();
final cartItems = cartCubit.getCurrentCartItems();
final total = cartCubit.total;
final coupon = cartCubit.getCurrentCoupon();
```

## الفوائد

1. **قابلية الصيانة**: كود منظم وسهل الفهم
2. **قابلية التوسع**: إضافة ميزات جديدة بسهولة
3. **إعادة الاستخدام**: استخدام المكونات في أماكن متعددة
4. **الاختبار**: اختبار كل مكون بشكل منفصل
5. **الأداء**: تحسين الأداء من خلال إعادة البناء المستهدفة
