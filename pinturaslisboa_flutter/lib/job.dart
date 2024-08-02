import 'client.dart';

class Job {
  String title = "";
  String address = "";
  String type = "";
  double progress = 0.0;
  String status = 'ongoing';
  //job status -> ongoing, completed, pending
  int rooms = 0;
  int bathrooms = 0;
  int kitchens = 0;
  int livingRooms = 0;
  int hallways = 0;
  int balconies = 0;
  int garages = 0;
  int otherRooms = 0;
  double totalUnits = 0.0;
  String typeOfPaint = "";
  String typeOfFinish = "";
  String previousColor = "";
  String newColor = "";
  String colorReference = "";
  bool furnished = false;
  String notes = "";

  //timestamps
  // timestamp for when the job was created
  DateTime created = DateTime.now();
  // timestamp for when the job was last updated
  DateTime updated = DateTime.now();

  //client info
  // ignore: unused_field
  Client? client;
  Job({
    required String title,
    required String address,
    required String type,
    required int rooms,
    required int bathrooms,
    required int kitchens,
    required int livingRooms,
    required int hallways,
    required int balconies,
    required int garages,
    required int otherRooms,
    required String typeOfPaint,
    required String typeOfFinish,
    required String previousColor,
    required String newColor,
    required String colorReference,
    required bool furnished,
    required String notes
    })  : this.title = title,
          this.address = address,
          this.type = type,
          this.progress = 0.0,
          this.rooms = rooms,
          this.bathrooms = bathrooms,
          this.kitchens = kitchens,
          this.livingRooms = livingRooms,
          this.hallways = hallways,
          this.balconies = balconies,
          this.garages = garages,
          this.otherRooms = otherRooms,
          this.totalUnits = rooms + (bathrooms * 0.5) + (kitchens * 0.5) + (livingRooms * 1.5) + (hallways * 0.5) + (balconies * 0.5) + (garages * 1) + (otherRooms * 1),
          this.typeOfPaint = typeOfPaint,
          this.typeOfFinish = typeOfFinish,
          this.previousColor = previousColor,
          this.newColor = newColor,
          this.colorReference = colorReference,
          this.furnished = furnished,
          this.notes = notes,
          this.created = DateTime.now(),
          this.updated = DateTime.now(),
          this.client = Client();
  
  Job.fromMap(Map<String, dynamic> map) {
      title = map['title'];
      address = map['address'];
      type = map['type'];
      progress = map['progress'];
      rooms = map['rooms'];
      bathrooms = map['bathrooms'];
      kitchens = map['kitchens'];
      livingRooms = map['livingRooms'];
      hallways = map['hallways'];
      balconies = map['balconies'];
      garages = map['garages'];
      otherRooms = map['otherRooms'];
      typeOfPaint = map['typeOfPaint'];
      typeOfFinish = map['typeOfFinish'];
      previousColor = map['previousColor'];
      newColor = map['newColor'];
      colorReference = map['colorReference'];
      furnished = map['furnished'] == 1;
      notes = map['notes'];
      totalUnits = rooms + (bathrooms * 0.5) + (kitchens * 0.5) + (livingRooms * 1.5) + (hallways * 0.5) + (balconies * 0.5) + (garages * 1) + (otherRooms * 1);
      created = map['created'];
      updated = map['updated'];
  }

  //toMap method
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'address': address,
      'type': type,
      'progress': progress,
      'status': status,
      'rooms': rooms,
      'bathrooms': bathrooms,
      'kitchens': kitchens,
      'livingRooms': livingRooms,
      'hallways': hallways,
      'balconies': balconies,
      'garages': garages,
      'otherRooms': otherRooms,
      'totalUnits': totalUnits,
      'typeOfPaint': typeOfPaint,
      'typeOfFinish': typeOfFinish,
      'previousColor': previousColor,
      'newColor': newColor,
      'colorReference': colorReference,
      'furnished': furnished ? 1 : 0,
      'notes': notes,
    };
  }



  bool isClientInfoAvailable() {
      if (client?.name != '' || client?.phone != '' || client?.email != '' || client?.notes != '' || client != null) {
          return true;
      } else {
          return false;
      }
  }

  void assignClient(Client client) {
    this.client = client;
  }

  void updateProgress(double progressToAdd) {

  }
}