import 'package:bid_here/Routes/routes.dart';
import 'package:bid_here/Widgets/update_user_info.dart';
import 'package:flutter/material.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(homeRoute, (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                              radius: 20.0,
                              child: Icon(
                                Icons.camera_alt,
                                size: 25.0,
                                color: Color(0xFF292929),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  BidHereUserInfoStream(),
                ],
              ),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
