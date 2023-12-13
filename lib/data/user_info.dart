import 'package:json_annotation/json_annotation.dart';

/// This allows the `Pharmacy` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user_info.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class UserInfo {
  String uid;
  String cf;
  String name;

  UserInfo(this.uid, this.cf, this.name);

  /// A necessary factory constructor for creating a new Pharmacy instance
  /// from a map. Pass the map to the generated `_$UserInfoFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Pharmacy.
  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PharmacyToJson`.
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}