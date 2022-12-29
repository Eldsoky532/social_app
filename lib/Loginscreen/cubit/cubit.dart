import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/Loginscreen/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value) async{
      print(value.user!.email);
      print(value.user!.uid);
      SharedPreferences preferences=await  SharedPreferences.getInstance();
      preferences.setString('UID', value.user!.uid);
      emit(SocialLoginSuccessState());
    }).catchError((onError){
      SocialLoginErrorState(onError.toString());
    });


  }


}
