class User{
  String? id;
  String? name;
  String? email;
  User({this.name , this.id ,this.email});

  User.fromFireStore(Map<String,dynamic>? data){
    id = data?["id"];
    name = data?["name"];
    email = data?["email"];
  }

  Map<String , dynamic> toFireStore(){
    return {
      "id":id,
      "name":name,
      "email":email
    };
  }


}