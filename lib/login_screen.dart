import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tuto_blc/auth/auth.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_event.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_page.dart';



class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.indigo, Colors.lightBlueAccent, Colors.white],
            ),
          ),
          child: Form(
            key: _formKey,
            child: 
             Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image.asset(
              //   'assets/images/logo.png', // Change the path to your image file
              //   height: 150.0,
              //   width: 150.0,
              // ),
              SizedBox(height: 20.0),
              Text(
                'Pouk Sa !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: passwordController,
                validator: (password){
                  if(password == null || password.isEmpty){
                    return 'Please enter your password';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    Map<String,dynamic> loginResult = await Auth().login(emailController.text, passwordController.text);
                    if(loginResult["status"]){
                      BlocProvider.of<BlocPage>(context).add(HomeEvent());
                      ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green, // Background color
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white), // Success icon
                                    SizedBox(width: 8), // Spacer
                                    Text(
                                      'Login successfully!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                duration: Duration(seconds: 2), // Adjust duration as needed
                              ),
                            );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login failed. Please check your credentials.'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  BlocProvider.of<BlocPage>(context).add(RegisterEvent());
                },
                child: Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          )
        ),
      ),
    );
  }
}