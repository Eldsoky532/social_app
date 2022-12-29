import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/MOdels/create_post.dart';
import 'package:social_app/homepage/cubit/cubit.dart';
import 'package:social_app/homepage/cubit/state.dart';

class Feedscreen extends StatelessWidget {
  const Feedscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext conext)=>SocialCubit()..getposts(),
       child: BlocConsumer<SocialCubit,Socialstates>(
         listener: (context,state){

         },
         builder: (context,state){
           print('hahahah');
           print(SocialCubit.get(context).posts!.length);
           return ConditionalBuilder(
             condition: SocialCubit.get(context).posts.length>0 ,
             builder: (context)=>SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Column(
                 children: [
                   Card(
                     clipBehavior: Clip.antiAliasWithSaveLayer,
                     elevation: 10.0,
                     margin: EdgeInsets.all(8.0),
                     child: Stack(
                       alignment: AlignmentDirectional.bottomEnd,
                       children: [
                         Image(
                           image: NetworkImage(
                               'https://img.freepik.com/free-photo/beautiful-portrait-young-black-woman-park-sunny-spring-day_181624-55096.jpg?w=996&t=st=1670067286~exp=1670067886~hmac=d12a197eb99789e8baeda292184211d596bac1a1a11523b83451732fa8383724'),
                           fit: BoxFit.cover,
                           height: 200,
                           width: double.infinity,
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                             'Communicate with friends',
                             style: Theme.of(context)
                                 .textTheme
                                 .subtitle1!
                                 .copyWith(color: Colors.white),
                           ),
                         ),
                       ],
                     ),
                   ),
                   ListView.separated(
                     itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts![index],context,index),
                     itemCount: SocialCubit.get(context).posts!.length,
                     shrinkWrap: true,
                     separatorBuilder: (context,index)=>SizedBox(
                       height: 8.0,
                     ),
                     physics: NeverScrollableScrollPhysics(),
                   ),
                 ],
               ),
             ),
             fallback: (context) => Center(child: CircularProgressIndicator()),
           );
         },
       ),

    );
  }

  Widget buildPostItem(SocialPostModel postmodel,context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage:NetworkImage ('${postmodel!.image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${postmodel!.fristname}',
                              style: TextStyle(height: 1.4),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          '${postmodel!.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                "${postmodel!.content}",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if(postmodel.postImage!='')
              Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                      image: NetworkImage('${postmodel.postImage}'), fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.heart_broken_outlined,
                                size: 16.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).like[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '120 comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage:NetworkImage ('${postmodel.image}'),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            '',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.heart_broken_outlined,
                          size: 16.0,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likeposts(SocialCubit.get(context).postsid[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
