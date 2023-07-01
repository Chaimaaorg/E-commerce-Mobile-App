class User{
  String? fullName,phone,email,address,urlPicture,company,ice;
  List<String>? favouriteProducts;

  //Constuctor
  User({this.fullName,this.email,this.phone,this.address,this.company,this.urlPicture,this.ice,this.favouriteProducts});
  //Create a map
  User.fromJson(Map<String,dynamic> json){
    fullName = json['fullname'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    company = json['company'];
    urlPicture = json['image_url'];
    ice = json['ice'];
    if (json['favouriteProducts'] != null) {
      favouriteProducts = List<String>.from(json['favouriteProducts']);
    } else {
      favouriteProducts = [];
    }  }
  Map<String, dynamic> toJson() {
    // object - data
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    //I've added these I needed them in the order approach
    data['ice'] = this.ice;
    data['company'] = this.company;
    return data;
  }

}