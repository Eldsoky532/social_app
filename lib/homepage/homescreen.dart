import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/homepage/cubit/cubit.dart';
import 'package:social_app/homepage/cubit/state.dart';

import 'newposts/newpost.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit(),
      child: BlocConsumer<SocialCubit,Socialstates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          return Scaffold(

              backgroundColor: Colors.grey.shade300,

              appBar: AppBar(

                iconTheme: IconThemeData(

                    color: Colors.black

                ),

                actions: [

                  IconButton(

                    icon:Icon(Icons.notification_important_outlined,color: Colors.black,), onPressed: () {},

                  ),

                  IconButton(

                    icon:Icon(Icons.search,color: Colors.black,), onPressed: () {},

                  )

                ],

                centerTitle: false,

                titleSpacing: 0,



                elevation: 0.0,

                backgroundColor: Colors.white,

              ),
            body:cubit.screens[cubit.currentindex],
            bottomNavigationBar:BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.currentindex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.home),label: ''),
                BottomNavigationBarItem(icon:Icon(Icons.post_add),label: ''),
                BottomNavigationBarItem(icon:Icon(Icons.map),label: ''),
                BottomNavigationBarItem(icon:Icon(Icons.settings),label: ''),
              ],
            )
          );
        },
      ),
    );
  }
}
