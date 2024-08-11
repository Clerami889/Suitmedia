import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:suit_media/user_controller.dart'; // Import the UserController

class ThirdScreen extends StatefulWidget {
  final String username;
  const ThirdScreen({super.key, required this.username});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final _scrollController = ScrollController();
  final _users = <User>[];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;
  final UserController _userController =
      Get.find(); // Get the UserController instance

  Future<void> _loadUsers() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$_page&per_page=10'));
    print(response.body); // Print the JSON response
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final users = (jsonData['data'] as List<dynamic>)
          .map((user) => User.fromJson(user as Map<String, dynamic>))
          .toList();
      setState(() {
        _users.addAll(users);
        _page++;
        _hasMoreData = jsonData['total_pages'] > _page;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshUsers() async {
    setState(() {
      _users.clear();
      _page = 1;
      _hasMoreData = true;
    });
    await _loadUsers();
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent * 0.8 &&
          _hasMoreData) {
        _loadUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Third Screen'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsers,
        child: _users.isEmpty
            ? Center(
                child: Text('No users found'),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: _users.length + (_hasMoreData ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _users.length) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(_users[index].avatar ?? ''),
                      ),
                      title: Text(
                          '${_users[index].first_name ?? ''} ${_users[index].last_name ?? ''}'),
                      subtitle: Text(_users[index].email ?? ''),
                      // In ThirdScreen
                      onTap: () {
                        _userController.setSelectedUserName(
                          '${_users[index].first_name ?? ''} ${_users[index].last_name ?? ''}',
                        );
                        Get.back(); // Go back to the previous screen
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GetBuilder<UserController>(
          // Wrap the Text widget with GetBuilder
          builder: (controller) {
            return Text(
              controller.selectedUserName.isEmpty
                  ? 'No user selected'
                  : controller.selectedUserName,
            );
          },
        ),
      ),
    );
  }
}

class User {
  final String? email;
  final String? first_name;
  final String? last_name;
  final String? avatar;

  User({this.email, this.first_name, this.last_name, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
