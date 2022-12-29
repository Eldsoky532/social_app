

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/Signupscreen/cubit/state.dart';

import '../../MOdels/usermodel.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String FristName,
    required String email,
    required String password,
    required String SecondName,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      usercreate(fristname: FristName,lastname: SecondName,email: email,uid: value.user!.uid);
    }).catchError((onError) {
      SocialRegisterErrorState(onError.toString());
    });


    }
  void usercreate(
      {required String fristname,
        required String lastname,
        required String email,
        required String uid,

      }) {
    SocialUserModel socialUserModel = new SocialUserModel(
        fristname: fristname, lastname: lastname, email: email, uid: uid,isEmailverify: false,image:'https://img.freepik.com/free-photo/beautiful-portrait-young-black-woman-park-sunny-spring-day_181624-55096.jpg?w=996&t=st=1670067286~exp=1670067886~hmac=d12a197eb99789e8baeda292184211d596bac1a1a11523b83451732fa8383724',
    coverr: 'https://img.freepik.com/free-photo/beautiful-portrait-young-black-woman-park-sunny-spring-day_181624-55096.jpg?w=996&t=st=1670067286~exp=1670067886~hmac=d12a197eb99789e8baeda292184211d596bac1a1a11523b83451732fa8383724',
    bio: "write you bio......"
    );

    FirebaseFirestore.instance.collection('User').doc(uid).set(
        socialUserModel.toMap()
    ).then((value) {

      emit(SocialCreateUserSucessstate());
    }).catchError((onError){
      emit(SocialCreateUserErrorState(onError));
    });

  }
}
