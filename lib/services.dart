import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FAuth;
import 'package:flutter/material.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_home.dart';
import 'package:fooddo/screens/screen_register_as_donor.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'classes/delivery_person.dart';
import 'classes/donation.dart';
import 'classes/notification.dart' as Notification;
import 'classes/user.dart';
import 'screens/screen_check_reg_status.dart';

class Data {
  static List<Donation> pastDonations = [];
  static User user;
  static String userPhone;
  static List<Donation> unclaimedDonations = [];
  static List<Donation> rejectedDonations = [];
  static List<Donation> acceptedDonations = [];
  static List<Donation> completedDonations = [];
  static List<Donation> enRouteDonations = [];
  static List<Notification.Notification> notifications = [];
  static List<DeliveryPerson> deliveryPersons = [];
}

class Services {
  static fetchUserPastDonation() async {
    Data.pastDonations.clear();
    Query pastDonations = FirebaseFirestore.instance
        .collection("donations")
        .where("donorId", isEqualTo: Data.user.id)
        .orderBy("timeStamp");
    await pastDonations.get().then((QuerySnapshot querySnapshot) {
      var docs = querySnapshot.docs;
      docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        Donation donation = new Donation(
          id: doc.id,
          date: data["date"],
          pickupAddress: data["pickupAddress"],
          recepient: data["recipient"],
          serving: data["servings"],
          status: data["status"],
          imgUrl: data["imgUrl"],
          donorId: data["donorId"],
        );
        Data.pastDonations.add(donation);
      });
    });
  }

  static fetchUserData(String phone) async {
    phone = phone.replaceFirst("+", "");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection("users").doc(phone).get().then(
      (DocumentSnapshot documentSnapshot) {
        Map<String, dynamic> userData = documentSnapshot.data();
        if (userData != null)
          Data.user = new User(
            id: phone,
            address: userData["address"],
            city: userData["city"],
            email: userData["email"],
            name: userData["name"],
            phone: phone,
            type: userData["type"],
            isDonor: userData["isDonor"],
            unreadNotifications: userData["unreadnotifs"],
          );
      },
    );
  }

  static Future<bool> checkIfLoggedIn() async {
    bool isLoggedIn;
    await FAuth.FirebaseAuth.instance
        .authStateChanges()
        .listen((FAuth.User user) {
      if (user == null)
        isLoggedIn = false;
      else {
        Data.userPhone = user.phoneNumber.replaceFirst("+", "");
        isLoggedIn = true;
      }
    });
    return isLoggedIn;
  }

  static postUserDonation(
    Donation donation, {
    String name,
    String phone,
    int waitingTime,
    List<String> moreImages,
  }) async {
    bool posted = false;
    CollectionReference donations =
        FirebaseFirestore.instance.collection("donations");
    await donations.add({
      "date": donation.date,
      "donorId": donation.donorId,
      "imgUrl": donation.imgUrl,
      "pickupAddress": donation.pickupAddress,
      "recipient": donation.recepient,
      "servings": donation.serving,
      "status": donation.status,
      "contact": donation.donorId,
      "name": name.isNotEmpty ? name : Data.user.name,
      "address": donation.longlat,
      "waitingTime": waitingTime > 0 ? waitingTime : 30,
      "city": Data.user.city,
      "timeStamp": DateTime.now(),
      "moreImages": moreImages,
    }).then((documentReference) async {
      await Services.fetchUserPastDonation();
      posted = true;
    });
    return posted;
  }

  static verifyPhone(String phone, BuildContext context) async {
    FAuth.FirebaseAuth auth = FAuth.FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 120),
      verificationCompleted: (FAuth.PhoneAuthCredential credential) async {
        FAuth.UserCredential result =
            await auth.signInWithCredential(credential);
        Navigator.of(context).pop();
        FAuth.User user = result.user;
        if (user != null) {
          Navigator.of(context).pushReplacementNamed(
            CheckRegisterationStatus.routeName,
            arguments: {"user": user},
          );
        } else {
          print("error occurred when adding user");
        }
      },
      verificationFailed: (FirebaseException e) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("${e.code}"),
              actions: [
                ContinuationButton(
                  buttonText: "Dismiss",
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      codeSent: (String verificationId, int resendToken) async {
        final _textController = new TextEditingController();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Please Enter your verification code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _textController,
                  ),
                ],
              ),
              actions: [
                ContinuationButton(
                  buttonText: "Confirm",
                  onTap: () async {
                    final code = _textController.text.trim();
                    FAuth.PhoneAuthCredential credential =
                        FAuth.PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: code);
                    FAuth.UserCredential result =
                        await auth.signInWithCredential(credential);
                    FAuth.User user = result.user;
                    if (user != null) {
                      Navigator.of(context).pushReplacementNamed(
                        CheckRegisterationStatus.routeName,
                        arguments: {"user": user},
                      );
                    } else {
                      print("error occurred when adding user");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static checkIfUserExists(String userPhone, BuildContext context) async {
    userPhone = userPhone.replaceFirst("+", "");
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection("users")
        .doc(userPhone)
        .get();
    if (user.exists) {
      Map<String, dynamic> userData = user.data();
      Data.user = new User(
        id: userPhone,
        address: userData["address"],
        city: userData["city"],
        email: userData["email"],
        name: userData["name"],
        phone: userData["userPhone"],
        type: userData["type"],
        isDonor: userData["isDonor"],
        unreadNotifications: userData["unreadnotifs"],
      );
      await Services.fetchUserPastDonation();
      Navigator.of(context).pushReplacementNamed(
        Home.routeName,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(RegisterAsDonor.routeName,
          arguments: {"phoneNumber": userPhone});
    }
  }

  static registerDonor(User user, BuildContext context,
      {registerationNumber}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection("users").doc(user.phone).set(
      {
        "address": user.address,
        "city": user.city,
        "email": user.email,
        "name": user.name,
        "phone": user.phone,
        "type": user.type,
        "donorId": user.phone,
        "isDonor": true,
        "unreadnotifs": false,
      },
    ).then((_d) async {
      await Services.fetchUserData(user.phone);
      Navigator.of(context).pushReplacementNamed(Home.routeName);
    });
  }

  static updateUser({String name, String email, String address}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot doc =
        await firebaseFirestore.collection("users").doc(Data.userPhone).get();
    if (doc.exists) {
      var userData = doc.data();
      userData["email"] = email;
      userData["name"] = name;
      userData["address"] = address;
      await firebaseFirestore
          .collection("users")
          .doc(Data.userPhone)
          .update(userData);
    }
  }

  static fetchUnclaimedDonations() async {
    Data.unclaimedDonations.clear();
    Query unclaimedDonations = FirebaseFirestore.instance
        .collection("donations")
        .where("status", isEqualTo: "waiting");
    await unclaimedDonations.get().then((QuerySnapshot querySnapshot) {
      var docs = querySnapshot.docs;
      docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        Donation donation = new Donation(
          id: doc.id,
          date: data["date"],
          pickupAddress: data["pickupAddress"],
          serving: data["servings"],
          status: data["status"],
          imgUrl: data["imgUrl"],
          recepient: data["recipient"],
          donorId: data["donorId"],
          waitingTime: data["waitingTime"],
          city: data["city"],
          longlat: data["address"],
          moreImages: data["moreImages"],
          timeStamp: data["timeStamp"],
        );
        Data.unclaimedDonations.add(donation);
      });
    });
  }

  static fetchAcceptedDonations() async {
    Data.acceptedDonations.clear();
    Query acceptedDonations = FirebaseFirestore.instance
        .collection("donations")
        .where("status", isEqualTo: "accepted");
    await acceptedDonations.get().then((QuerySnapshot querySnapshot) {
      var docs = querySnapshot.docs;
      docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        Donation donation = new Donation(
          id: doc.id,
          date: data["date"],
          pickupAddress: data["pickupAddress"],
          serving: data["servings"],
          status: data["status"],
          imgUrl: data["imgUrl"],
          recepient: data["recipient"],
          donorId: data["donorId"],
          waitingTime: data["waitingTime"],
          city: data["city"],
          longlat: data["address"],
          moreImages: data["moreImages"],
          timeStamp: data["timeStamp"],
        );
        Data.acceptedDonations.add(donation);
      });
    });
  }

  static fetchRejectedDonations() async {
    Data.rejectedDonations.clear();
    Query rejectedDonations = FirebaseFirestore.instance
        .collection("donations")
        .where("status", isEqualTo: "rejected");
    await rejectedDonations.get().then((QuerySnapshot querySnapshot) {
      var docs = querySnapshot.docs;
      docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        Donation donation = new Donation(
          id: doc.id,
          date: data["date"],
          pickupAddress: data["pickupAddress"],
          serving: data["servings"],
          status: data["status"],
          imgUrl: data["imgUrl"],
          recepient: data["recipient"],
          donorId: data["donorId"],
          waitingTime: data["waitingTime"],
          city: data["city"],
          longlat: data["address"],
          moreImages: data["moreImages"],
          timeStamp: data["timeStamp"],
        );
        Data.rejectedDonations.add(donation);
      });
    });
  }

  static fetchCompletedDonations() async {
    Data.completedDonations.clear();
    Query completedDonations = FirebaseFirestore.instance
        .collection("donations")
        .where("status", isEqualTo: "completed");
    await completedDonations.get().then((QuerySnapshot querySnapshot) {
      var docs = querySnapshot.docs;
      docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        Donation donation = new Donation(
          id: doc.id,
          date: data["date"],
          pickupAddress: data["pickupAddress"],
          serving: data["servings"],
          status: data["status"],
          imgUrl: data["imgUrl"],
          recepient: data["recipient"],
          donorId: data["donorId"],
          waitingTime: data["waitingTime"],
          city: data["city"],
          longlat: data["address"],
          moreImages: data["moreImages"],
          timeStamp: data["timeStamp"],
        );
        Data.completedDonations.add(donation);
      });
    });
  }

  static fetchEnRouteDonations() async {
    Data.enRouteDonations.clear();
    Query enRouteDonations = FirebaseFirestore.instance
        .collection("donations")
        .where("status", isEqualTo: "collecting");
    await enRouteDonations.get().then((QuerySnapshot querySnapshot) {
      var docs = querySnapshot.docs;
      docs.forEach((doc) {
        print(doc.id);
        Map<String, dynamic> data = doc.data();
        Donation donation = new Donation(
          id: doc.id,
          date: data["date"],
          pickupAddress: data["pickupAddress"],
          serving: data["servings"],
          status: data["status"],
          imgUrl: data["imgUrl"],
          recepient: data["recipient"],
          donorId: data["donorId"],
          waitingTime: data["waitingTime"],
          city: data["city"],
          longlat: data["address"],
          moreImages: data["moreImages"],
          timeStamp: data["timeStamp"],
        );
        Data.enRouteDonations.add(donation);
      });
    });
  }

  static acceptDonation(String donationId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot doc =
        await firebaseFirestore.collection("donations").doc(donationId).get();
    if (doc.exists) {
      var donationDocument = doc.data();
      await firebaseFirestore
          .collection("users")
          .doc(donationDocument["donorId"])
          .collection("notifications")
          .add(
        {
          "donationId": doc.id,
          "status": "accepted",
          "timeStamp": DateFormat.yMMMEd().format(DateTime.now()).toString(),
        },
      );
      donationDocument["status"] = "accepted";
      firebaseFirestore
          .collection("donations")
          .doc(donationId)
          .update(donationDocument);
    }
    await Services.generateNotification(doc["donorId"]);
  }

  static rejectDonation(String donationId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot doc =
        await firebaseFirestore.collection("donations").doc(donationId).get();
    if (doc.exists) {
      var donationDocument = doc.data();
      await firebaseFirestore
          .collection("users")
          .doc(donationDocument["donorId"])
          .collection("notifications")
          .add(
        {
          "donationId": doc.id,
          "status": "rejected",
          "timeStamp": DateFormat.yMMMEd().format(DateTime.now()).toString(),
        },
      );
      donationDocument["status"] = "rejected";
      firebaseFirestore
          .collection("donations")
          .doc(donationId)
          .update(donationDocument);
    }
    await Services.generateNotification(doc["donorId"]);
  }

  static fetchNotifications(String userPhone) async {
    Data.notifications.clear();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    QuerySnapshot notificationsQuerySnapshot = await firebaseFirestore
        .collection("users")
        .doc(userPhone)
        .collection("notifications")
        .get();
    List<QueryDocumentSnapshot> notifications = notificationsQuerySnapshot.docs;
    if (notifications.length > 0) {
      notifications.forEach(
        (notification) {
          Data.notifications.add(
            new Notification.Notification(
              id: notification.id,
              donationId: notification["donationId"],
              status: notification["status"],
              timeStamp: notification["timeStamp"],
            ),
          );
        },
      );
    }
  }

  static fetchDeliveryPersons(String city) async {
    Data.deliveryPersons.clear();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var documents = await firebaseFirestore
        .collection("deliverypersons")
        .where("city", isEqualTo: city)
        .get();
    if (documents.docs.length > 0) {
      documents.docs.forEach(
        (doc) {
          Data.deliveryPersons.add(
            new DeliveryPerson(
              id: doc.id,
              name: doc["name"],
              contact: doc["phone"],
              vehicleCapacity: doc["vehicleCapacity"],
            ),
          );
        },
      );
    }
  }

  static assignDeliveryPerson(
      {Donation donation, DeliveryPerson deliveryPersons}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("deliverypersons")
        .doc(deliveryPersons.id)
        .collection("assignments")
        .add(
      {
        "donationId": donation.id,
        "donorContact": donation.donorId,
        "pickUpAddress": donation.pickupAddress,
        "servings": donation.serving,
        "date": donation.date,
        "address": donation.longlat,
        "seen": false,
      },
    );
    await firebaseFirestore
        .collection("users")
        .doc(donation.donorId)
        .collection("notifications")
        .add(
      {
        "donationId": donation.id,
        "status": "EnRoute",
        "timeStamp": DateFormat.yMMMEd().format(DateTime.now()).toString(),
      },
    );
    var doc =
        await firebaseFirestore.collection("donations").doc(donation.id).get();
    var donationDocument = doc.data();
    donationDocument["status"] = "collecting";
    firebaseFirestore
        .collection("donations")
        .doc(donation.id)
        .update(donationDocument);
    await Services.generateNotification(donation.donorId);
  }

  static notificationRead() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(Data.userPhone)
        .update({"unreadnotifs": false});
    await Services.fetchUserData(Data.userPhone);
  }

  static generateNotification(String userPhone) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore
        .collection("users")
        .doc(userPhone)
        .update({"unreadnotifs": true});
  }

  // Image Utilities
  static Future<String> uploadImage(File _file, {String fileName}) async {
    firebase_storage.UploadTask uploadTask = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("donations/$fileName.jpg")
        .putFile(_file);
    firebase_storage.TaskSnapshot storagesnap = await uploadTask;
    String imageURL = await storagesnap.ref.getDownloadURL();
    return imageURL;
  }
}
