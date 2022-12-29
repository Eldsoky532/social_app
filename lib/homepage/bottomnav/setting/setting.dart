import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/MOdels/usermodel.dart';
import 'package:social_app/component/component.dart';
import 'package:social_app/editprofile/editpro.dart';
import 'package:social_app/homepage/cubit/cubit.dart';
import 'package:social_app/homepage/cubit/state.dart';

class Settingscreen extends StatelessWidget {
   Settingscreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
   var fristController = TextEditingController();
   var emailController = TextEditingController();
   var lastController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit,Socialstates>(
        listener: (context,state){
          if(state is SocialGetUserSuccessState)
            {
              SocialCubit.get(context).getUserData();

            }
        },
        builder: (context,state){

          var userModel= SocialCubit.get(context).userModel;
          return ConditionalBuilder(
              condition:SocialCubit.get(context).userModel!=null,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    4.0,
                                  ),
                                  topRight: Radius.circular(
                                    4.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image:NetworkImage('${userModel!.coverr}') as ImageProvider,

                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage("${userModel!.image}'") as ImageProvider,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${userModel!.fristname }',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(width: 5,),
                        Text('${userModel!.lastname }',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),

                    Text('${userModel!.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text('100',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text('Posts',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text('250',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text('Phots',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text('20k',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text('Followers',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text('80',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text('Following',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: [
                                  Text('100',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text('Vedio',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                        ],
                      ),
                    ),
                    defaultButton(function: (){

                         Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) =>
                                   EditProfile()),
                         );


                    }, text: "Edit profile")
                  ],
                ),
              ),
              fallback:  (context) => Center(child: CircularProgressIndicator())
          );
        },
      ),
    );
  }

}
