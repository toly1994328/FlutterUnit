
part 'g/license.g.dart';

class License {

  String name;
  String spdxId;

  License(this.name,this.spdxId);

  factory License.fromJson(Map<String, dynamic> json) => _$LicenseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}
