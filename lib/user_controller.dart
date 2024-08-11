// UserController.dart
import 'package:get/get.dart';

class UserController extends GetxController {
  RxString _selectedUserName = ''.obs;

  String get selectedUserName => _selectedUserName.value;

  void setSelectedUserName(String name) {
    _selectedUserName.value = name;
  }
}
