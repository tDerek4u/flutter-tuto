import 'package:cloud_firestore/cloud_firestore.dart';

class PostResource{
  Stream<QuerySnapshot>getPosts()async*{
    Stream<QuerySnapshot> posts = FirebaseFirestore.instance.collection("posts").snapshots();
    yield* posts;
  }


  createPost(String title,String description){
    FirebaseFirestore.instance.collection("posts").add({
      "title": title,
      "description": description
    });
  }

  updatePost(String title,String description,String id){
    FirebaseFirestore.instance.collection("posts").doc(id).update({
      "title": title,
      "description": description
    });
  }

  deletePost(String id){
    FirebaseFirestore.instance.collection("posts").doc(id).delete();
  }

  Future<DocumentSnapshot>getPostById(String id)async{
    DocumentSnapshot post = await FirebaseFirestore.instance.collection("posts").doc(id).get();
    return post;
  }
}