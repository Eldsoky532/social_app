import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/MOdels/message_model.dart';
import 'package:social_app/MOdels/usermodel.dart';
import 'package:social_app/homepage/bottomnav/feeds/feeds.dart';
import 'package:social_app/homepage/bottomnav/setting/setting.dart';
import 'package:social_app/homepage/bottomnav/users/users.dart';
import 'package:social_app/homepage/cubit/state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../MOdels/create_post.dart';
import '../newposts/newpost.dart';

class SocialCubit extends Cubit<Socialstates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  int currentindex = 0;

  List<Widget> screens = [
    Feedscreen(),
    NewPostScreen(),
    Userscreen(),
    Settingscreen()
  ];

  void changeBottomNav(int index) {
    currentindex = index;
    emit(SocialChangeBottomNav());
  }

  getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

   File? proimage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedfile = await picker.getImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      proimage = File(pickedfile.path);

      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image Selected');
      emit(SocialProfileImagePickedErroState());
    }
  }

   File? coverimage;

  Future getCoverImage() async {
    final pickedfile = await picker.getImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      coverimage = File(pickedfile.path);

      emit(ChangerCoverImageSuccessState());
    } else {
      print('No image Selected');
      emit(ChangerCoverImageErrorState());
    }
  }


 Future <void> uploadProfileImage({

    required String name,

    required String lastname,

    required String bio,

  })async{

    //كدا انا بكريت instance من ال storage

    await firebase_storage.FirebaseStorage.instance

    //كدا بقوله انا فين في الstorage

        .ref()

    //كدا بقةله هتحرك ازاي جوا ال storage

    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage

        .child('User/${Uri.file(proimage!.path).pathSegments.last}')

    //كدا بعمل رفع للصوره

        .putFile(proimage!).then((value){

      value.ref.getDownloadURL().then((value){

        emit(UpdateProfileImageSuccessState());

        updateUserProfile(

          name: name,

          lastname: lastname,

          bio: bio,

          profile: value,

        );

      }).catchError((error){

        emit(UpdateProfileImageErrorState());

      });

    }).catchError((error){

      emit(UpdateProfileImageErrorState());

    });

  }

  Future<void> uploadCoverImage ({

    required String name,

    required String lastname,

    required String bio,

  })async{

    //كدا انا بكريت instance من ال storage

  await  firebase_storage.FirebaseStorage.instance

    //كدا بقوله انا فين في الstorage

        .ref()

    //كدا بقةله هتحرك ازاي جوا ال storage

    //ال users دا هو الملف اللي هخزن الصوره فيه ف ال storage

        .child('User/${Uri.file(coverimage!.path).pathSegments.last}')

    //كدا بعمل رفع للصوره

        .putFile(coverimage!).then((value){

      value.ref.getDownloadURL().then((value){

        emit(UpdateCoverImageSuccessState());

        updateUserProfile(

          name: name,

          lastname: lastname,

          bio: bio,

          cover: value,

        );

      }).catchError((error){

        emit(UpdateCoverImageErrorState());

      });

    }).catchError((error){

      emit(UpdateCoverImageErrorState());

    });

  }


  Future<void> updateUserProfile({

    required String name,

    required String lastname,

    required String bio,

    String? cover,

    String? profile,

  })async{

    emit(UpdateUserDataLoadingState());



     SocialUserModel model=SocialUserModel(

      fristname: name,

      lastname: lastname,

      bio:bio,

      coverr: cover??userModel!.coverr,

      isEmailverify: false,

      image:profile??userModel!.image,

      email: userModel!.email,

      uid:FirebaseAuth.instance.currentUser!.uid,

    );



    await FirebaseFirestore.instance

        .collection('User')

        .doc(model!.uid)

        .update(model.toMap())

        .then((value){

      getUserData();

    }).then((value) {
      emit(UpdateUserDatasucessState());
    }).catchError((error){

      emit(UpdateUserDataErrorState());

    });

  }



  File? postimage;
  Future<void> getPostImage()async{
    final pickedFile=await picker.getImage(source: ImageSource.gallery);
    if(pickedFile!=null)
      {
        postimage=File(pickedFile.path);
        emit(ChangerPostImagePickedsucessState());
      }else
        {
          print('no post image selected');
          emit(ChangerPostImagePickedErrorState());
        }
  }


void removePostImage()
{
  postimage=null;
  emit(SocialRemovePostImageSuccessState());
}


Future<void> uploadPostImage({

  required String? dataname,
  required String? text,
  required String? content,

})async{

    emit(SocialCreatePostLoadingState());

    await firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postimage!.path).pathSegments.last}')
    .putFile(postimage!).then((value){
      value.ref.getDownloadURL().then((value) {

        createPost(dateTime:dataname,text: text,postImage: value,content: content);
        //emit(SocialCreatePostSuccessState());
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
}


  Future<void> createPost({

    required String? dateTime,

    required String? text,
    required String? content,


    String? postImage,

  }) async{
    emit(SocialCreatePostLoadingState());
    getUserData();
    SocialPostModel model = SocialPostModel(

      fristname: userModel!.fristname,

      image: userModel!.image,

      userId:FirebaseAuth.instance.currentUser!.uid,

      dateTime: dateTime,

      postImage: postImage ?? '',

      text: text,
      content: content

    );


    await FirebaseFirestore.instance

        .collection('Post')

        .add(model.toMap())

        .then((value) {
          print('hahahahaha');
          print(value.toString());
      emit(SocialCreatePostSuccessState());
    })
        .catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }


  List<SocialPostModel> posts=[];
  List<String> postsid=[];
  List<int> like=[];
  
  
  Future<void> getposts()
  async{
    emit(SocialGetPostloadingState());
    await FirebaseFirestore.instance
        .collection('Post')
        .get()
        .then((value){
          value.docs.forEach((element) {
           element.reference
               .collection('Like')
               .get()
               .then((value){
             like.add(value.docs!.length);
             postsid.add(element.id);
             posts.add(SocialPostModel.fromJson(element.data()));
             emit(SocialGetPostSuccessState());

           }).catchError((onError){

           });
          });
          emit(SocialGetPostSuccessState());

    }).catchError((error){
      emit(SocialGetPostErrorState());
    });
  }
  

Future<void> likeposts(String id)
async{

    getUserData();
   await FirebaseFirestore.instance
        .collection('Post')
        .doc(id)
        .collection('Like')
        .doc(userModel!.uid)
        .set({'like':true})
        .then((value){
          emit(SocialGetLikesSuccessState());
    }).catchError((onError){
      emit(SocialCreatePostErrorState());
    });







}








  List<SocialUserModel> users = [];


  void getUsers()
  {
    FirebaseFirestore.instance.collection('User').get().then((value)
    {
      value.docs.forEach((element)
      {
          users.add(SocialUserModel.fromJson(element.data()));      });

      emit(SocialGetAllUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }




  Future<void> sendMessage({
  required String receiverId,
    required String dateTime,
    required String text,
})async{
    getUserData();
    MessageModel model=MessageModel(
      text: text,
      senderId: userModel!.uid,
      receiverId: receiverId,
      dateTime: dateTime

    );

    
    FirebaseFirestore.instance.collection('User')
    .doc(userModel!.uid)
    .collection('Chat')
    .doc(receiverId)
    .collection('message')
    .add(model.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError){
      emit(SocialSendMessageSuccessState());
    });


    FirebaseFirestore.instance
        .collection('User')
        .doc(receiverId)
        .collection('Chat')
        .doc(userModel!.uid)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });



  }

  List<MessageModel> messages = [];



  void getMessages({
    required String receiverId,
  }) {
    getUserData();
    FirebaseFirestore.instance
        .collection('User')
        .doc(userModel!.uid)
        .collection('Chat')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessageSuccessState());
    });
  }
}


