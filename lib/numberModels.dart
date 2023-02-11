// ignore_for_file: non_constant_identifier_names



class RandomNumber {
  int body;


  RandomNumber({
    required this.body,

  }); 

  factory RandomNumber.fromJson(Map<String, dynamic> json) {
    return RandomNumber(
      body: json["number"],

    );
  }
}
