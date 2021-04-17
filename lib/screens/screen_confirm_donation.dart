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
  String _name = Data.user.name;
  String _pickUpAddress = Data.user.address;
  int _waitingTime = 60;
  Map<String, String> tempMap;
  String uniqueId;
  File _file;
  List<File> _moreImages;
  bool _loading = false;
  String _imgUrl =
      "https://littlepapercrown.files.wordpress.com/2012/07/full-plate-of-junk.jpg";
  int _numberOfImages = 0;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (_loading) LinearProgressIndicator(),
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
                      icon: Icon(_file != null ? Icons.check : Icons.camera),
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
                        itemCount: _numberOfImages > 3 ? 3 : _numberOfImages,
                        itemBuilder: (_, index) {
                          return IconButton(
                            icon: Icon(Icons.add, color: Colors.black),
                            onPressed: () {},
                          );
                        },
                      ),
                    )
                  ],
                ),
                ContinuationButton(
                  buttonText: "Donate",
                  onTap: () async {
                    setState(() {
                      _loading = true;
                    });
                    Map<String, double> longlat = await getCurrentLocation();
                    if (_file != null)
                      _imgUrl = await Services.uploadImage(
                        _file,
                        fileName: uniqueId,
                      );
                    Services.postUserDonation(
                      new Donation(
                        city: Data.user.city,
                        recepient: "Edhi Care Center",
                        imgUrl: _imgUrl,
                        date: DateFormat().add_yMd().format(DateTime.now()),
                        pickupAddress: _pickUpAddress,
                        serving: int.parse(args["servings"].round().toString()),
                        status: "waiting",
                        donorId: Data.userPhone,
                        longlat: longlat,
                      ),
                      name: _name,
                      waitingTime: _waitingTime,
                    );
                    setState(() {
                      _loading = false;
                    });
                    await Services.fetchUserPastDonation();
                    Navigator.of(context).pushReplacementNamed(Home.routeName);
                  },
                ),
              ],
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
    uniqueId = Uuid().v4();
    final compressedImageFile = File('$_path/img_$uniqueId.jpg')
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
