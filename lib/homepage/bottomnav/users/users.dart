import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/MOdels/usermodel.dart';
import 'package:social_app/homepage/cubit/cubit.dart';
import 'package:social_app/homepage/cubit/state.dart';

class Userscreen extends StatelessWidget {
  const Userscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialCubit()..getUsers(),
        child: BlocConsumer<SocialCubit, Socialstates>(
          listener: (context, state) {},
          builder: (context, state) {
            print('hahahaha');
              print(SocialCubit.get(context).users.length);
            return ConditionalBuilder(
              condition: SocialCubit.get(context).users.length > 0,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildChatItem(
                      SocialCubit.get(context).users[index], context),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                  itemCount: SocialCubit.get(context).users.length),
            );
          },
        ));
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        splashColor: Colors.amber.shade900,
        onTap: () {
          // pageRouter(context , ChatDetails(userModel: model,));
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(

                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '${model.fristname}'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              '${model.bio}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
