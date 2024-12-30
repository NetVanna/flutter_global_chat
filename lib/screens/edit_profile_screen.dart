import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_chat/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var db = FirebaseFirestore.instance;


  @override
  void initState() {
    nameController.text =
        Provider.of<UserProvider>(context, listen: false).name;
    super.initState();
  }
  void updateName() {
    Map<String, dynamic> updateData = {
      "name":nameController.text
    };
    db
        .collection("users")
        .doc(Provider.of<UserProvider>(context,listen: false).userId)
        .update(updateData);
    Provider.of<UserProvider>(context,listen: false).getUserDetails();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  updateName();
                }
              },
              child: const Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This name is required";
                  } else if (value.length < 3) {
                    return "This name is more than 4 character";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                controller: nameController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
