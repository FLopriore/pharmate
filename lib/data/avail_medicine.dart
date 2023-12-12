import 'package:json_annotation/json_annotation.dart';
import 'package:pharmate/data/pharmacy.dart';

/// This allows the `AvailMedicine` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'avail_medicine.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class AvailMedicine {
  Pharmacy f;
  int qt;

  AvailMedicine(this.f, this.qt);

  /// A necessary factory constructor for creating a new AvailMedicine instance
  /// from a map. Pass the map to the generated `_$AvailMedicineFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Medicine.
  factory AvailMedicine.fromJson(Map<String, dynamic> json) => _$AvailMedicineFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$AvailMedicineToJson`.
  Map<String, dynamic> toJson() => _$AvailMedicineToJson(this);
}