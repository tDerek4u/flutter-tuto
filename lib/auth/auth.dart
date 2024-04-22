import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tuto_blc/login_screen.dart';

class Auth{

  Future<Map<String,dynamic>> register(String userEmail,String userPassword)async{
      Map<String,dynamic> res = {"status" : false };
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword
      );
      res["status"] = true;
    }catch(e){
      print(e);
    }
    print(res);
    return res;
  }

  Future<Map<String,dynamic>> login(String userEmail,String userPassword)async{
    Map<String,dynamic> res = {"status" : false };
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword
      );
      res["status"] = true;
    }catch(e){
      print(e);
    }
    return res;
  }

  Future<void> logout()async{
    try{
      await FirebaseAuth.instance.signOut();
  
    }catch(e){
      print(e);
    }
  }

  
}

// class YourWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await Auth().logout();
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (context) => LoginScreen()),
//             );
//           },
//           child: Text('Logout'),
//         ),
//       ),
//     );
//   }
// }