import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/services.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Settings extends StatefulWidget {
  static final routeName = "/settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool changesMade;
  bool updating;
  bool _imageUploading;
  var _key;
  String _userName, _userEmail, _userAddress, _userId, _imageUrl;
  File _file;
  var _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _key = GlobalKey<FormState>();
    _userName = Data.user.name;
    _userEmail = Data.user.email;
    _userAddress = Data.user.address;
    _userId = Data.user.id;
    _imageUrl = Data.user.imageUrl ?? "";
    _imageUploading = false;
    changesMade = false;
    updating = false;
    _error = "";
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Fooddo",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 45,
            color: Colors.black,
          ),
        ),
        actions: [
          changesMade
              ? IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    if (_userName != Data.user.name ||
                        _userAddress != Data.user.address ||
                        _userEmail != Data.user.email) {
                      if (_key.currentState.validate()) {
                        setState(() {
                          updating = true;
                        });
                        _key.currentState.save();
                        await Services.updateUser(
                          name: _userName,
                          address: _userAddress,
                          email: _userEmail,
                        );
                        setState(() {
                          updating = false;
                          changesMade = false;
                        });
                      }
                    }
                  },
                )
              : SizedBox(),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            if (updating)
              Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: height * 0.3,
                          width: width,
                          child: _imageUploading
                              ? Center(child: CircularProgressIndicator())
                              : Image.network(_imageUrl),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            TextButton(
                              child: Text("Update Image"),
                              onPressed: () async {
                                setState(() {
                                  _imageUploading = true;
                                });
                                imageProcessing(context, height);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _userName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                            labelText: "Enter your name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Name Can not be empty";
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                changesMade = true;
                                _userName = value;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _userAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                            labelText: "Enter your address",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Address Can not be empty";
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                changesMade = true;
                                _userAddress = value;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: _userEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                            labelText: "Enter your email",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Email Can not be empty";
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                changesMade = true;
                                _userEmail = value;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_error, style: TextStyle(color: Colors.red)),
                            ContinuationButton(
                              buttonText: "Update",
                              onTap: () async {
                                if (_userName != Data.user.name ||
                                    _userAddress != Data.user.address ||
                                    _userEmail != Data.user.email) {
                                  if (_key.currentState.validate()) {
                                    setState(() {
                                      updating = true;
                                      _error = "";
                                    });
                                    _key.currentState.save();
                                    await Services.updateUser(
                                      name: _userName,
                                      address: _userAddress,
                                      email: _userEmail,
                                    );
                                    setState(() {
                                      updating = false;
                                      changesMade = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    _error = "Nothing to Update";
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Image Utilities
  Future<String> uploadImage(File _file) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("users/$_userId.jpg")
        .putFile(_file);
    TaskSnapshot storagesnap = await uploadTask;
    String imageURL = await storagesnap.ref.getDownloadURL();
    String updatedImageUrl =
        await Services.updateUserProfileImageUrl(imageURL, _userId);
    setState(() {
      _imageUrl = updatedImageUrl;
      _imageUploading = false;
    });
    Data.user.imageUrl = updatedImageUrl;
    return imageURL;
  }

  compressImage() async {
    final _tempDir = await getTemporaryDirectory();
    final _path = _tempDir.path;
    im.Image imageFile = im.decodeImage(_file.readAsBytesSync());
    final compressedImageFile = File('$_path/img_user.jpg')
      ..writeAsBytesSync(im.encodeJpg(imageFile, quality: 80));
    setState(() {
      _file = compressedImageFile;
    });
    await uploadImage(_file);
  }

  Future getImageFromCamera() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      _file = image;
    });
    await compressImage();
  }

  Future getImageFromGallery() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      _file = image;
    });
    await compressImage();
  }

  imageProcessing(context, height) {
    //only showing modal bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(top: 30),
        height: height * 0.3,
        child: Column(
          children: <Widget>[
            Text('Select Source'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 50,
                        ),
                        onPressed: getImageFromCamera,
                      ),
                    ),
                    Text("Capture"),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      child: IconButton(
                        icon: Icon(
                          Icons.photo,
                          size: 50,
                        ),
                        onPressed: getImageFromGallery,
                      ),
                    ),
                    Text('Gallery'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
