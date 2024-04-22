
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tuto_blc/auth/auth.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_event.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_page.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(29.0),
            child: Form(
              key: _formkey,
              child: 
              Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: nameController,
                  validator: (name) {
                    if(name == null || name.isEmpty){
                      return 'Please enter your name';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: emailController,
                  validator: (email) {
                    if(email == null || email.isEmpty){
                      return 'Please enter your email';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: passwordController,
                  validator: (password) {
                    if(password == null || password.isEmpty){
                      return 'Please enter your password';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: ()async {
                    if(_formkey.currentState!.validate()){
                      Map<String,dynamic> status =  await Auth().register(emailController.text, passwordController.text);
                      if(status['status'] == true){
                        ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green, // Background color
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white), // Success icon
                                    SizedBox(width: 8), // Spacer
                                    Text(
                                      'Registered successfully!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                duration: Duration(seconds: 2), // Adjust duration as needed
                              ),
                            );
                        BlocProvider.of<BlocPage>(context).add(HomeEvent());

                      }
                    }
                  },
                  child: Text('Register'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.indigo),
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<BlocPage>(context).add(LoginEvent());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            )
          ),
        ),
      ),
    );
  }
}