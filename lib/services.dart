import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FAuth;
import 'package:flutter/material.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_home.dart';
import 'package:fooddo/screens/screen_register_as_donor.dart';

import 'classes/donation.dart';
import 'classes/user.dart';
import 'screens/screen_check_reg_status.dart';

class Data {
  static List<Donation> pastDonations = [];
  static User user;
  static String userPhone;
  static List<Donation> unclaimedDonations = [];
  static List<Donation> rejectedDonations = [];
  static List<Donation> acceptedDonations = [];
}

class Services {
  static fetchUserPastDonation() async {
    Data.pastDonations.clear();
    Query pastDonations = FirebaseFirestore.instance
        .collection("donations")
        .where("donorId", isEqualTo: Data.user.id);
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
        print(userData);
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

  static postUserDonation(Donation donation,
      {String name, String address, String phone, int waitingTime}) async {
    bool posted = false;
    CollectionReference donations =
        FirebaseFirestore.instance.collection("donations");
    await donations.add({
      "date": donation.date,
      "donorId": Data.user.id,
      "imgUrl":
          "https://littlepapercrown.files.wordpress.com/2012/07/full-plate-of-junk.jpg",
      "pickupAddress": donation.pickupAddress,
      "recipient": "Edhi Care Center",
      "servings": donation.serving,
      "status": donation.status,
      "contact": Data.user.phone,
      "name": name.isNotEmpty ? name : Data.user.name,
      "address": address.isNotEmpty ? address : Data.user.address,
      "waitingTime": waitingTime > 0 ? waitingTime : 30,
    }).then((documentReference) async {
      await Services.fetchUserPastDonation();
      posted = true;
    });
    print("posted: " + posted.toString());
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
          print("errors");
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
                      print("errors");
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
        );
        Data.rejectedDonations.add(donation);
      });
    });
  }

  static acceptDonation(String donationId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot doc =
        await firebaseFirestore.collection("donations").doc(donationId).get();
    if (doc.exists) {
      var donationDocument = doc.data();
      donationDocument["status"] = "accepted";
      firebaseFirestore
          .collection("donations")
          .doc(donationId)
          .update(donationDocument);
    }
  }

  static rejectDonation(String donationId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot doc =
        await firebaseFirestore.collection("donations").doc(donationId).get();
    if (doc.exists) {
      var donationDocument = doc.data();
      donationDocument["status"] = "rejected";
      firebaseFirestore
          .collection("donations")
          .doc(donationId)
          .update(donationDocument);
    }
  }
}
