import 'package:cloud_firestore/cloud_firestore.dart';

import 'classes/donation.dart';
import 'classes/user.dart';

class Data {
  static List<Donation> pastDonations = [];
  static User user = new User(
    id: "iFV9JhQdkXakT175trww",
    address: "R#10,H#12",
    city: "Peshawar",
    email: "john@doe.com",
    name: "Joh Doe",
    phone: "3123456789",
    type: "individual",
  );
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
          id: data["donorId"],
          date: data["date"],
          pickupAddress: data["pickupAddress"],
          recepient: data["recipient"],
          serving: data["servings"],
          status: data["status"],
          imgUrl: data["imgUrl"],
        );
        Data.pastDonations.add(donation);
      });
    });
  }

  static Future<bool> postUserDonation(Donation donation,
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
}
