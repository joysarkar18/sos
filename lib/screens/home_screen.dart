import 'package:flutter/material.dart';
import 'package:sos/screens/add_phone_number_screen.dart';
import 'package:sos/screens/instruction_screen.dart';
import 'package:sos/screens/login_screen.dart';
import 'package:sos/utils/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "SOS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/Rectangle 42.png"),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 241, 236, 236),
          Color.fromARGB(255, 124, 123, 123)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InstructionScreen(
                              isFromHome: true,
                            ),
                          ));
                    },
                    child: Container(
                      height: 142,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/189664-removebg-preview 1.png"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Instructions",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPhoneNumberScreen(),
                          ));
                    },
                    child: Container(
                      height: 142,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/Ellipse 2.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Emergency Numbers",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterForm(
                              isEdit: true,
                            ),
                          ));
                    },
                    child: Container(
                      height: 142,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/Ellipse 3.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "View Saved Details",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      sendMessageToAll();
                    },
                    child: Container(
                      height: 142,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: AssetImage("assets/sos_send.jpeg"))),
                      // child: Center(
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         "assets/sos_send.jpeg",
                      //         height: 140,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
