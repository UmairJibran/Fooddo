import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../services.dart';

class ConfirmDonation extends StatefulWidget {
  static final routeName = "/confirm-donation";

  @override
  _ConfirmDonationState createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmDonation> {
  int _selectedImage = 0;
  String _name = Data.user.name;
  String _pickUpAddress = Data.user.address;
  bool freshFoodAgreement = false;
  int _waitingTime = 60;
  Map<String, String> tempMap;
  String uniqueId;
  File _file;
  var _moreImages = List<File>.filled(3, null, growable: false);
  bool _loading = false;
  String _imgUrl =
      "https://littlepapercrown.files.wordpress.com/2012/07/full-plate-of-junk.jpg";
  int _numberOfImages = 0;

  @override
  void initState() {
    super.initState();
    uniqueId = Uuid().v4();
  }

  dynamic getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return {
      "longitude": position.longitude,
      "latitude": position.latitude,
    };
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Fooddo",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 35,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: (_loading)
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Review Donation",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: _name,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: _pickUpAddress,
                          helperText: "Pickup Location",
                        ),
                        onChanged: (value) {
                          setState(() {
                            _pickUpAddress = value;
                          });
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: _waitingTime.toString(),
                          suffixText: "Minutes",
                          helperText:
                              "We will notify the recepients to come in the provided time",
                        ),
                        onChanged: (value) {
                          setState(() {
                            _waitingTime = int.parse(value);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                                _file != null ? Icons.check : Icons.camera),
                            onPressed: () async {
                              await imageProcessing(
                                  context, MediaQuery.of(context).size.height);
                            },
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  _numberOfImages > 3 ? 3 : _numberOfImages,
                              itemBuilder: (_, index) {
                                return IconButton(
                                  icon: Icon(
                                    _moreImages[index] == null
                                        ? Icons.add
                                        : Icons.check,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _selectedImage = (index + 1);
                                    });
                                    await imageProcessing(context,
                                        MediaQuery.of(context).size.height);
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Center(
                            child: freshFoodAgreement
                                ? Icon(
                                    Icons.check,
                                    size: 15,
                                  )
                                : null,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            freshFoodAgreement = !freshFoodAgreement;
                          });
                        },
                      ),
                      Text("I agree that the food is fresh, and not stale."),
                    ],
                  ),
                  ContinuationButton(
                    buttonText: "Donate",
                    onTap: freshFoodAgreement
                        ? () {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: Text('Confirm Donation?'),
                                actions: [
                                  FlatButton(
                                    textColor: Colors.black,
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('CANCEL'),
                                  ),
                                  FlatButton(
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      setState(() {
                                        _loading = true;
                                      });
                                      Map<String, double> longlat =
                                          await getCurrentLocation();
                                      var moreImages = List<String>.filled(
                                          3, "",
                                          growable: false);
                                      if (_file != null)
                                        _imgUrl = await Services.uploadImage(
                                          _file,
                                          fileName: uniqueId + "0",
                                        );
                                      if (_moreImages[0] != null) {
                                        var tempImage =
                                            await Services.uploadImage(
                                          _moreImages[0],
                                          fileName: uniqueId + "1",
                                        );
                                        moreImages[0] = (tempImage);
                                      }
                                      if (_moreImages[1] != null) {
                                        var tempImage =
                                            await Services.uploadImage(
                                          _moreImages[1],
                                          fileName: uniqueId + "2",
                                        );
                                        moreImages[1] = (tempImage);
                                      }
                                      if (_moreImages[2] != null) {
                                        var tempImage =
                                            await Services.uploadImage(
                                          _moreImages[2],
                                          fileName: uniqueId + "3",
                                        );
                                        moreImages[2] = (tempImage);
                                      }
                                      Services.postUserDonation(
                                        new Donation(
                                          city: Data.user.city,
                                          recepient: "Edhi Care Center",
                                          imgUrl: _imgUrl,
                                          date: DateFormat()
                                              .add_yMd()
                                              .format(DateTime.now()),
                                          pickupAddress: _pickUpAddress,
                                          serving: int.parse(args["servings"]
                                              .round()
                                              .toString()),
                                          status: "waiting",
                                          donorId: Data.userPhone,
                                          longlat: longlat,
                                        ),
                                        moreImages: moreImages,
                                        name: _name,
                                        waitingTime: _waitingTime,
                                      );
                                      setState(() {
                                        _loading = false;
                                      });
                                      await Services.fetchUserPastDonation();
                                      Navigator.of(context)
                                          .pushReplacementNamed(Home.routeName);
                                    },
                                    child: Text('ACCEPT'),
                                  ),
                                ],
                              ),
                            );
                          }
                        : () {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: Text(
                                  "Please Agree to Fresh Food Agreement",
                                ),
                              ),
                            );
                          },
                  ),
                ],
              ),
      ),
    );
  }

  compressImage() async {
    final _tempDir = await getTemporaryDirectory();
    final _path = _tempDir.path;
    im.Image imageFile = im.decodeImage(_file.readAsBytesSync());
    final compressedImageFile = File('$_path/img_$uniqueId$_selectedImage.jpg')
      ..writeAsBytesSync(im.encodeJpg(imageFile, quality: 80));
    setState(() {
      _file = compressedImageFile;
      _numberOfImages += 1;
    });
  }

  Future getImageFromCamera() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      if (_selectedImage == 0)
        _file = image;
      else if (_selectedImage == 1)
        _moreImages[0] = image;
      else if (_selectedImage == 2)
        _moreImages[1] = image;
      else if (_selectedImage == 3) _moreImages[2] = image;
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
      if (_selectedImage == 0)
        _file = image;
      else if (_selectedImage == 1)
        _moreImages[0] = image;
      else if (_selectedImage == 2)
        _moreImages[1] = image;
      else if (_selectedImage == 3) _moreImages[2] = image;
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
