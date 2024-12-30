import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat/providers/user_provider.dart';
import 'package:global_chat/screens/chat_room_screen.dart';
import 'package:global_chat/screens/profile_screen.dart';
import 'package:global_chat/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chartRoomList = [];
  List<String> chatRoomIds = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void getChartRoom() {
    db.collection("chartrooms").get().then(
      (snapShotData) {
        for (var singleChartRoom in snapShotData.docs) {
          chartRoomList.add(singleChartRoom.data());
          chatRoomIds.add(singleChartRoom.id.toString());
        }
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    getChartRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Global Chat"),
        leading: InkWell(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Text(userProvider.name[0]),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              leading: CircleAvatar(
                child: Text(userProvider.name[0]),
              ),
              title: Text(
                userProvider.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(userProvider.email),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.person),
              title: const Text("User"),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false,
                );
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: chartRoomList.length,
        itemBuilder: (context, index) {
          String chartRoomName = chartRoomList[index]["chartroom_name"] ?? "";
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomScreen(
                    chatRoomName: chartRoomName,
                    chatRoomId: chatRoomIds[index],
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey[900],
              child: Text(
                chartRoomName[0],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(chartRoomName),
            subtitle: Text(
              chartRoomList[index]["desc"] ?? "",
              style: const TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
