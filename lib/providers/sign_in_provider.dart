import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Districap/models/User.dart' as MyUser;

import '../config.dart';
class SignInProvider extends ChangeNotifier {
  // instance of firebaseauth, facebook and google
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  File? _pickedImage;
  File? get pickedImage => _pickedImage;
  bool? remember;
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  //hasError, errorCode, provider,uid, email, name, imageUrl
  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _provider;
  String? get provider => _provider;

  String? _uid;
  String? get uid => _uid;

  String? _name;
  String? get name => _name;

  String? _address;
  String? get address => _address;

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;

  String? _email;
  String? get email => _email;

  String? _company;
  String? get company => _company;

  String? _ice;
  String? get ice => _ice;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  SignInProvider() {
    checkSignInUser();
  }


  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    remember = s.getBool("remember_me") ?? false; // Get "Remember me" preference
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // sign in with google
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // executing our authentication
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // signing to firebase user instance
        final User userDetails =
        (await firebaseAuth.signInWithCredential(credential)).user!;

        // now save all values
        _name = userDetails.displayName;
        _email = userDetails.email;
        _imageUrl = userDetails.photoURL;
        _provider = "GOOGLE";
        _uid = userDetails.uid;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
            "You already have an account with us. Use correct provider";
            _hasError = true;
            notifyListeners();
            break;

          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }


  // ENTRY FOR CLOUDFIRESTORE
  Future getUserDataFromFirestore(uid) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get();
    if (snapshot.exists) {
      // The document exists in Firestore
      _uid = snapshot['uid'];
      _name = snapshot['fullname'];
      _address = snapshot['address'];
      _phoneNumber = snapshot['phone'];
      _email = snapshot['email'];
      _imageUrl = snapshot['image_url'];
      _provider = snapshot['provider'];
      if(snapshot['company'] !=null && snapshot['ice'] != null)
        {
          _company = snapshot['company'];
          _ice = snapshot['ice'];
        }

      saveDataToSharedPreferences();
    } else {
      // The document does not exist in Firestore
      print('Document does not exist.');
      // Handle the case where the document does not exist (e.g., show default values or show an error message)
    }
  }


  Future saveDataToFirestore() async {
    final DocumentReference r =
    FirebaseFirestore.instance.collection("Users").doc(uid);
    await r.set({
      "favouriteProducts":null,
      "fullname": _name,
      "email": _email,
      "address":_address,
      "phone":_phoneNumber,
      "uid": _uid,
      "image_url": _imageUrl,
      "provider": _provider,
    });
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('fullname', _name!);
    await s.setString('email', _email!);
    await s.setString('uid', _uid!);
    await s.setString('image_url', _imageUrl!);
    await s.setString('provider', _provider!);
    if(_phoneNumber != null)
      {
        await s.setString('phone', _phoneNumber!);
        if(_address != null)
          {
            await s.setString('address', _address!);
          }
      }
    if(_company != null)
      {
        await s.setString('company', _company!);

      }
    if(_ice != null)
    {
      await s.setString('ice', _ice!);
    }
    notifyListeners();
  }

  Future<void> getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('fullname');
    _email = s.getString('email');
    _imageUrl = s.getString('image_url');
    _uid = s.getString('uid');
    _provider = s.getString('provider');
    // Check if 'address' key exists, if not, set a default value
    _address = s.getString('address') ?? 'Morocco';
    // Check if 'phone' key exists, if not, set a default value
    _phoneNumber = s.getString('phone') ?? '+212 6**** ****';
    // Update the text field controllers with the stored data

    notifyListeners();
  }


  // checkUser exists or not in cloudfirestore
  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
    await FirebaseFirestore.instance.collection('Users').doc(_uid).get();
    if (snap.exists) {
      print("EXISTING USER");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  // signout
  Future userSignOut() async {
    await firebaseAuth.signOut;
    await googleSignIn.signOut();
    _isSignedIn = false;
    notifyListeners();
    // clear all storage information
    clearStoredData();
    // SharedPreferences prefs =
    // await SharedPreferences.getInstance();
    // await prefs.setBool('ON_BOARDING', false);

  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();

    // Define the keys you want to keep
    List<String> keysToKeep = ["ON_BOARDING","remember_me", "email", "password","cart","messages"];

    // Get all the keys in SharedPreferences
    Set<String> allKeys = s.getKeys();

    // Loop through all the keys and remove the ones that are not in the keysToKeep list
    for (String key in allKeys) {
      if (!keysToKeep.contains(key)) {
        s.remove(key);
      }
    }
  }
  void updateImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }
  Future<void> updateUserProfile(MyUser.User updatedUser,BuildContext context,String routeName) async {
    try {
        final User? user = firebaseAuth.currentUser;
        final String uid = user?.uid ?? "";
        final DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(uid);
        // Update the user's data in Firestore
        await userRef.update(updatedUser.toJson());

        // Update the email in the authentication credential if needed
        if (user != null && updatedUser.email != null && updatedUser.email != user.email) {
          if (user.providerData.any((provider) => provider.providerId == "password")) {
            // The user signed in with Email/Password provider
            await user.updateEmail(updatedUser.email!);
            print("Email updated in authentication credential.");
          } else if (user.providerData.any((provider) => provider.providerId == "google.com")) {
            // The user signed in with Google Sign-In provider
            GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
            GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

            if (googleAuth != null) {
              AuthCredential googleCredential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken!,
                idToken: googleAuth.idToken!,
              );
              await user.linkWithCredential(googleCredential);
              print("Google account linked with email/password provider.");
            } else {
              print("User is not signed in with Google.");
            }
          }
        }
        print("User profile updated successfully.");
        Navigator.pushReplacementNamed(context,routeName);

    } catch (e) {
      // Handle errors if any.
      print("Error updating user profile: $e");
    }
  }

  Future<File?> pickImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final pickedImageFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      return File(pickedImageFile.path);
    }
    return null;
  }

  ImageProvider<Object> getProfileImageProvider() {
    if (pickedImage != null) {
      return FileImage(pickedImage!);
    } else if (imageUrl != null) {
      return NetworkImage(imageUrl!);
    } else {
      return AssetImage("assets/images/Profile Image.png"); // Replace with the path to your default image asset.
    }
  }

  Future<void> updatePickedImage(File image) async {
    _pickedImage = image;
    notifyListeners();
    try {
      final storage = FirebaseStorage.instance;
      String imagePath = 'users/${_uid}/profile_image.jpg'; // Customize the path as needed
      TaskSnapshot snapshot = await storage.ref(imagePath).putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Now, update the 'image_url' field in Firestore
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(_uid)
          .update({"image_url": downloadUrl});

      print("Profile image updated successfully.");
    } catch (e) {
      print("Error updating profile image: $e");
    }
  }


  void phoneNumberUser(User user, email, name,uid) {
    _name = name;
    _email = email;
    _imageUrl =
    "https://winaero.com/blog/wp-content/uploads/2017/12/User-icon-256-blue.png";
    _uid = uid;
    _phoneNumber =user.phoneNumber;
    _provider = "PHONE";
    notifyListeners();
  }


}