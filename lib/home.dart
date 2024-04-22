import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tuto_blc/auth/auth.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_event.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_page.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_state.dart';
import 'package:flutter_tuto_blc/login_screen.dart';
import 'package:flutter_tuto_blc/posts/new_post.dart';
import 'package:flutter_tuto_blc/posts/post_list.dart';


class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to MyApp'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("ZHM"),
              accountEmail: Text("data@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "Z",
                  style: TextStyle(fontSize: 40.0, color: Colors.blueAccent),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Post List'),
              onTap: () {
                 BlocProvider.of<BlocPage>(context).add(PostListEvent());
                 Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.post_add),
              title: Text('New Post'),
              onTap: () {
                BlocProvider.of<BlocPage>(context).add(NewPostEvent());
                 Navigator.pop(context);
              },
            ),
            Divider(),
           ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await Auth().logout();
                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green, // Background color
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white), // Success icon
                                    SizedBox(width: 8), // Spacer
                                    Text(
                                      'Logout successfully!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                duration: Duration(seconds: 1), // Adjust duration as needed
                              ),
                            );
                BlocProvider.of<BlocPage>(context).add(LoginEvent());
              },
            ),
          ],
        ),
      ),
      body:  BlocBuilder<BlocPage, BlocState>(
      builder: (BuildContext context, state) {
        if (state is NewPostState) {
          return NewPost();
        } else if (state is PostListState) {
          return PostList();
        }else{
          return PostList();
        }
      },
    ),
    );
  }
}