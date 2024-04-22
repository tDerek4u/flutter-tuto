import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tuto_blc/firebase_posts/post_resource.dart';

class EditPost extends StatefulWidget {
  EditPost(this.id);

  final String id;
  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: FutureBuilder(
        builder: ((context,AsyncSnapshot<DocumentSnapshot> snapshots) {
          snapshots.data!.data() as Map<String,dynamic> ;
          Map<String,dynamic> post = snapshots.data!.data() as Map<String,dynamic> ;
            titleController = TextEditingController(text: post['title']);
            descriptionController = TextEditingController(text: post['description']);
          return Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: 
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              validator: (value) {
                if(value ==null || value.isEmpty){
                  return "Please enter a title";
                }
              },
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              validator: (value) {
                if(value ==null || value.isEmpty){
                  return "Please enter a titlr";
                }
              },
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: ()async {
              
                if(_formKey.currentState!.validate()){
                   try{
                    String post =  await PostResource().updatePost(widget.id,titleController.text, descriptionController.text);
                   }catch(e){
                     print(e);
                   }
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green, // Background color
                        content: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white), // Success icon
                            SizedBox(width: 8), // Spacer
                            Text(
                              'Post updated successfully!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 2), // Adjust duration as needed
                      ),
                    );
                   titleController.text = "";
                  descriptionController.text = "";
                  Navigator.pop(context);
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
        )
      );
        }),
        future: PostResource().getPostById(widget.id),

      )
    );
  }
}
