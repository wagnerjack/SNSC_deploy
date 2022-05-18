// ignore_for_file: non_constant_identifier_names

class Age {
  int? lowerRange;
  int? upperRange;
  bool? allAges;

  Age({
    this.lowerRange,
    this.upperRange,
    this.allAges,
  });

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lowerRange'] = lowerRange;
    _data['upperRange'] = upperRange;
    _data['allAges'] = allAges;
    return _data;
  }

  factory Age.fromJson(Map<String, dynamic> Json) {
    Age newAge = Age(
        lowerRange: Json['lowerRange'],
        upperRange: Json['upperRange'],
        allAges: Json['allAges']);
    return newAge;
  }
}

class Organization {
  String? id;
  String? name;
  String? descriptions;
  String? primaryContactName;
  String? primaryContactRole;
  String? primaryEmail;
  String? fullEmail;
  String? primaryPhoneNumber;
  String? fullPhoneNumber;
  String? primaryWebsite;
  String? fullWebsite;
  List<dynamic>? disabilitiesServed;
  List<dynamic>? servicesProvided;
  List<dynamic>? statesServed;
  List<dynamic>? townsNewHampshire;
  List<dynamic>? townsVermont;
  Age? agesServed;
  String? fee;
  String? feeDescription;
  List<dynamic>? insurancesAccepted;

  Organization(
      {this.id,
      this.name,
      this.descriptions,
      this.primaryContactName,
      this.primaryContactRole,
      this.primaryEmail,
      this.fullEmail,
      this.primaryPhoneNumber,
      this.fullPhoneNumber,
      this.primaryWebsite,
      this.fullWebsite,
      this.disabilitiesServed,
      this.servicesProvided,
      this.statesServed,
      this.townsNewHampshire,
      this.townsVermont,
      this.agesServed,
      this.fee,
      this.feeDescription,
      this.insurancesAccepted});

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['descriptions'] = descriptions;
    _data['primaryContactName'] = primaryContactName;
    _data['primaryContactRole'] = primaryContactRole;
    _data['primaryEmail'] = primaryEmail;
    _data['fullEmail'] = fullEmail;
    _data['primaryPhoneNumber'] = primaryPhoneNumber;
    _data['fullPhoneNumber'] = fullPhoneNumber;
    _data['primaryWebsite'] = primaryWebsite;
    _data['fullWebsite'] = fullWebsite;
    _data['disabilitiesServed'] = disabilitiesServed;
    _data['servicesProvided'] = servicesProvided;
    _data['statesServed'] = statesServed;
    _data['townsNewHampshire'] = townsNewHampshire;
    _data['townsVermont'] = townsVermont;
    _data['agesServed'] = agesServed?.toJson();
    _data['fee'] = fee;
    _data['feeDescription'] = feeDescription;
    _data['insurancesAccepted'] = insurancesAccepted;
    return _data;
  }

  factory Organization.fromJson(Map<String, dynamic> Json) {
    Organization newOrganization = Organization(
      id: Json['id'] ?? Json['_id'],
      name: Json['name'],
      descriptions: Json['descriptions'],
      primaryContactName: Json['primaryContactName'],
      primaryContactRole: Json['primaryContactRole'],
      primaryEmail: Json['primaryEmail'],
      fullEmail: Json['fullEmail'],
      primaryPhoneNumber: Json['primaryPhoneNumber'],
      fullPhoneNumber: Json['fullPhoneNumber'],
      primaryWebsite: Json['primaryWebsite'],
      fullWebsite: Json['fullWebsite'],
      disabilitiesServed: Json['disabilitiesServed'],
      servicesProvided: Json['servicesProvided'],
      statesServed: Json['statesServed'],
      townsNewHampshire: Json['townsNewHampshire'],
      townsVermont: Json['townsVermont'],
      agesServed: Age.fromJson(Json['agesServed']),
      fee: Json['fee'],
      feeDescription: Json['feeDescription'],
      insurancesAccepted: Json['insurancesAccepted'],
    );
    return newOrganization;
  }
}
