class Donation {
  final String id;
  final String imgUrl;
  final int serving;
  final String status;
  final String recepient;
  final String date;
  final String pickupAddress;
  final String donorId;
  final int waitingTime;
  final String city;

  Donation({
    this.id,
    this.donorId,
    this.pickupAddress,
    this.imgUrl,
    this.serving,
    this.status,
    this.recepient,
    this.date,
    this.waitingTime,
    this.city,
  });
}
