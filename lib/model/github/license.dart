
part 'g/license.g.dart';

class License {

  String? name;
  String? spdxId;

  License(this.name,this.spdxId);

  String get type {
    return spdxId ==null?"未知":spdxId!;
  }


  factory License.fromJson(Map<String, dynamic> json) => _$LicenseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}
