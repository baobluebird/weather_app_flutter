class User{
  String? fall;

  User({this.fall});

  User.fromJson(Map<String, dynamic> json) {
    fall = json['fall'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fall'] = this.fall;
    return data;
  }
}