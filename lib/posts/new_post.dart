import 'package:flutter/material.dart';
import 'package:flutter_tuto_blc/firebase_posts/post_resource.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Padding(
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
                  return "Please enter a titlr";
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
                    String post =  await PostResource().createPost(titleController.text, descriptionController.text);
                   
                    print(post);

                   
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
                              'Post created successfully!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 2), // Adjust duration as needed
                      ),
                    );
                   titleController.text = "";
                  descriptionController.text = "";
                }
              },
              child: Text('Add Post'),
            ),
          ],
        ),
        )
      ),
    );
  }
}
