class UserModel {
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? addressLine1;
  String? addressLine2;
  String? state;
  String? city;
  String? pincode;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.pincode,
  });

  // receiving data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['userId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      addressLine1: map['addressLine1'],
      addressLine2: map['addressLine2'],
      city: map['city'],
      state: map['state'],
      pincode: map['pincode'],
    );
  }

// sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'pincode': pincode,
    };
  }
}
