

class User {
   String? id;
   String? firstname;
   String? lastname;
   String? email;
   String? birthday;
   String? phonenumber;
   String? password;
   String? image;
   int? coins;
   int? steps;

  User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.birthday,
    this.phonenumber,
    required this.password,
    this.image,
    this.coins,
    this.steps,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthday: json['birthday'],
      phonenumber: json['phonenumber'],
      password: json['password'],
      image: json['image'],
      coins: json['coins'],
      steps:json['steps']
    );
  }
   Map<String, dynamic> toJson() {
     return {
       '_id': id,
       'firstname': firstname,
       'lastname': lastname,
       'email': email,
       'birthday': birthday,
       'phonenumber': phonenumber,
       'password': password,
       'image': image,
       'coins': coins,
       'steps': steps,

     };
   }

}
