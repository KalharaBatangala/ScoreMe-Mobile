import 'package:flutter/material.dart';
import 'src/LoginScreen.dart';
import 'src/components/LiveIndicator.dart';
import 'src/components/StartButton.dart';
import 'src/TeamSelectionPage.dart';
import 'src/LiveScorePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fypmobile/src/SignUpScreen.dart';

//primary color theme of the app
const Color primaryColor = Color(0xFF000435);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Signup with Bottom Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    LoginPage(),
    //ScorePage(),
    SignupPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.login_rounded),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'SignUp',
          ),


        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: primaryColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}





//
// class ScorePage extends StatelessWidget {
//   const ScorePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               child: Text('Match Score',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//               ),
//             ),
//             SizedBox(width: 20,),
//             Container(
//               child: Icon(Icons.live_tv_rounded, color: Colors.white,),
//             ),
//
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               child: LiveIndicator(),
//             ),
//
//           ],
//         )
//
//       ),
//     );
//   }
// }

// ///////////////////////////////////////////////////////////////
