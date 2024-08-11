import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suit_media/third_screen.dart';
import 'package:suit_media/user_controller.dart';

class SecondScreen extends StatefulWidget {
  final String username;

  const SecondScreen(
      {super.key, required this.username}); // Added closing parenthesis

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Second Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${widget.username}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Obx(() => Text(
                  _userController.selectedUserName ?? '',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff2B637B),
                    fixedSize: Size.fromWidth(300),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.to(ThirdScreen(
                      // Added closing parenthesis
                      username: widget.username,
                    ));
                  },
                  child: Text('Choose a User'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedUserName(String newUserName) {
    setState(() {
      _userController.setSelectedUserName(newUserName);
    });
  }
}
