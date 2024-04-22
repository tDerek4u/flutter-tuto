
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tuto_blc/firebase_posts/post_resource.dart';
import 'package:flutter_tuto_blc/posts/edit_post.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: PostResource().getPosts(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshots.hasError) {
          return Center(
            child: Text('Error: ${snapshots.error}'),
          );
        }
        return ListView.builder(
          itemCount: snapshots.data!.docs.length,
          itemBuilder: (context, index) {

            var document = snapshots.data!.docs[index];
            var title = document['title'];
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Text("${snapshots.data!.docs[index]['title']}"),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditPost(document.id)),
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () {
                          try {
                            PostResource().deletePost(document.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green, // Background color
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white), // Success icon
                                    SizedBox(width: 8), // Spacer
                                    Text(
                                      'Post deleted successfully!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                duration: Duration(seconds: 2), // Adjust duration as needed
                              ),
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
