// واجهة (Interface) تحدد طريقة التعامل مع الـ ID في النماذج
abstract class IDOrderModel {
  void setId(String id); // دالة لإضافة ID
  Map<String, dynamic> toJson(); // تحويل النموذج إلى JSON
}
