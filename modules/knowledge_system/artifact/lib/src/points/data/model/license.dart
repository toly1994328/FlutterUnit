

class License {

  String? name;
  String? spdxId;

  License(this.name,this.spdxId);

  String get type {
    return spdxId ==null?"未知":spdxId!;
  }


  factory License.fromJson(Map<String, dynamic> json) => License(
    json['name'] as String?,
    json['spdx_id'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'spdx_id': spdxId,
  };
}
