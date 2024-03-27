import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/screens/sign_in.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Welcome to Dashboard'),
              const SizedBox(height: 20),
              Text('Email: ${FirebaseAuth.instance.currentUser?.email}'),
            ],
          ),
        ));
  }
}
