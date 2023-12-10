import 'package:flutter/material.dart';

import '../../Util/ApiPaths.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelUser.dart';
import '../../widget/SearchUserBarWidget.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  User? selectedUser; // Initialize selectedUser to null
  String selectedRole = 'Student';
  List<String> roles = ['Student', 'Teacher', 'Administrator'];

  @override
  void initState() {
    super.initState();
  }

  void lockUser() {
    final String apiUrl = ApiPaths.getLockUserPath(
        selectedUser!.email); // Thêm từ khóa vào đường dẫn API
    FetchDataFromAPI(apiUrl, setData);
  }

  void unlockUser() {
    final String apiUrl = ApiPaths.getUnlockUserPath(
        selectedUser!.email); // Thêm từ khóa vào đường dẫn API
    FetchDataFromAPI(apiUrl, setData);
  }

  void setRoleAdmin(String roleName) {
    final String apiUrl = ApiPaths.getAdminSetRolePath(
        selectedUser!.email, roleName); // Thêm từ khóa vào đường dẫn API
    FetchDataFromAPI(apiUrl, setData);
    print(roleName);
  }

  void removeRoleAdmin(String roleName) {
    final String apiUrl = ApiPaths.getAdminRemoveRolePath(
        selectedUser!.email, roleName); // Thêm từ khóa vào đường dẫn API
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý người dùng'),
      ),
      body: Center(
        child: selectedUser != null
            ? Card(
          elevation: 5.0,
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chi tiết người dùng',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  title: Text(
                    'Họ tên',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    selectedUser!.name,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    selectedUser!.email,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                // Add more user details as needed
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        lockUser();
                      },
                      child: Text('Khóa'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        unlockUser();
                      },
                      child: Text('Mở khóa'),
                    ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  onChanged: (newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                  items: roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Chọn Vai trò',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setRoleAdmin(selectedRole);
                      },
                      child: Text('Thêm vai trò'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        removeRoleAdmin(selectedRole);
                      },
                      child: Text('Xóa vai trò'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
            : Text(
          'Chưa có dữ liệu',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SearchUserBarApp(
                onUserSelected: (User user) {
                  setState(() {
                    selectedUser = user;
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ); // Replace with your search page widget
            },
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
