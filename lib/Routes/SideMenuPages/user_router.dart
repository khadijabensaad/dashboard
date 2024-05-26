import 'package:admintest/Controllers/CRUDControllers/users_api.dart';
import 'package:admintest/Widgets/appbarwideget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/CRUDModels/user_model.dart';
import '../../constants/const_colors.dart';

class UsersRoute extends StatefulWidget {
  UsersRoute({super.key});

  @override
  State<UsersRoute> createState() => _UsersRouteState();
}

class _UsersRouteState extends State<UsersRoute> {
  final UserCallAPi _userApiCall = UserCallAPi();
  List<String> actionList = ['Activate/Deactivate user', 'Delete user'];
  String? _selectedAction;

  void _onSelected(String value, UserModel user) async {
    setState(() {
      _selectedAction = value;
    });
    if (value == 'Delete user') {
      await _deleteUser(user.id);
    } else if (value == 'Activate/Deactivate user') {
      await _deactivate(user);
    }
  }

  Future<void> _deleteUser(String id) async {
    await _userApiCall.deleteUser(id);
    setState(() {});
  }

  Future<void> _deactivate(UserModel user) async {
    await _userApiCall.deactivate(user.id);
    setState(() {
      user.activated = !user.activated;
    });
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: darkGrey.withOpacity(0.1),
            blurRadius: 12,
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<List<UserModel>>(
          future: _userApiCall.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return const Center(child: Text('Failed to load users'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No users available'));
            } else {
              final users = snapshot.data!;
              return DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: Center(
                      child: Text(
                        'Username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text(
                        'Role',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text(
                        'Activated',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Center(
                      child: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    numeric: true,
                    size: ColumnSize.S,
                  ),
                ],
                rows: users.map((user) {
                  return DataRow(cells: [
                    DataCell(Center(child: Text(user.username))),
                    DataCell(Center(child: Text(user.role))),
                    DataCell(Center(child: Text(user.email))),
                    DataCell(
                        Center(child: Text(user.activated ? 'true' : 'false'))),
                    DataCell(
                      Center(
                        child: PopupMenuButton<String>(
                          surfaceTintColor: Colors.white,
                          shadowColor: Colors.grey.shade300,
                          icon: const Icon(CupertinoIcons.ellipsis_vertical,
                              color: Colors.black, size: 20),
                          onSelected: (String value) {
                            _onSelected(value, user);
                          },
                          itemBuilder: (BuildContext context) {
                            return actionList.map((String item) {
                              return PopupMenuItem<String>(
                                value: item,
                                child: Center(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins', fontSize: 12),
                                  ),
                                ),
                              );
                            }).toList();
                            /*     Center(
                        child: PopupMenuButton<String>(
                          surfaceTintColor: Colors.white,
                          shadowColor: Colors.grey.shade300,
                          icon: const Icon(CupertinoIcons.ellipsis_vertical,
                              color: Colors.black, size: 20),
                          onSelected: (String value) {
                            _onSelected(value, user);
                          },
                          itemBuilder: (BuildContext context) {
                            return actionList.map((String item) {
                              return PopupMenuItem<String>(
                                value: item,
                                child: Center(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins', fontSize: 12),
                                  ),
                                ),
                              );
                            }).toList();*/
                          },
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              );
            }
          },
        ),
      ),
    );

    return Scaffold(
      appBar: const AppBarWidget(title: 'Users Management'),
      body: futureBuilder,
    );
  }
}


/*
import 'package:admintest/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UsersRoute extends StatelessWidget {
  const UsersRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: darkGrey.withOpacity(0.1),
                blurRadius: 12)
          ],
          border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      //   CustomText(text: "All Users")
                      Text("All Users",
                          style: TextStyle(
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: [
                        DataColumn2(
                          label: Text('Username'),
                          size: ColumnSize.L,
                        ),
                        DataColumn(
                          label: Text('Role'),
                        ),
                        DataColumn(
                          label: Text('Email'),
                        ),
                        DataColumn(
                          label: Text('activated'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          10,
                          (index) => const DataRow(cells: [
                                DataCell(Text('Khadija')),
                                DataCell(Text('Administrator')),
                                DataCell(Text('khadijabensaad4@gmail.com')),
                                DataCell(Text('True')),
                              ]))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
*/