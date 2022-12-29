class SocialPostModel{

  String? userId;

  String? fristname;

  String? image;

  String? dateTime;

  String? text;
  String? content;


  String? postImage;

  SocialPostModel({

    this.userId,

    this.fristname,

    this.image,

    this.dateTime,

    this.text,
    this.content,

    this.postImage

  });

  SocialPostModel.fromJson(Map<String , dynamic> json){

    userId=json['userId'];

    fristname=json['fristname'];

    image=json['image'];

    dateTime=json['dateTime'];

    text=json['text'];
    content=json['content'];

    postImage=json['postImage'];

  }



  Map <String , dynamic> toMap(){

    return{

      'userId':userId,

      'fristname':fristname,

      'image':image,

      'dateTime':dateTime,

      'text':text,
      'content':content,

      'postImage':postImage,

    };

  }

}