import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/homepage/cubit/cubit.dart';
import 'package:social_app/homepage/cubit/state.dart';
import 'package:social_app/onBoarding/onboarding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();




  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create:(context)=> SocialCubit()..getUserData()..getposts(),
        ),

      ],
      child: BlocConsumer<SocialCubit,Socialstates>(
        listener: (context,state){},
        builder:(context,state)=> MaterialApp(

          home:Scaffold(body: onBoardingScreen()),
        ),
      ),
    );
  }
}



