import 'dart:async';
import 'dart:convert';
import 'package:storage/storage.dart';
import 'package:fx_dao/fx_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin Cacheable<V> {
  FutureOr<bool> save(V po);

  FutureOr<V?> find({bool shouldRemove = true});

  FutureOr<bool> remove();
}

mixin TimeoutCache<V> on Cacheable<V> {
  String get cacheKey;

  int get maxCacheMs => 1000 * 60 * 30;

  SharedPreferences get spf => SpStorage().spf;

  ConvertorList<V> get convertor;

  @override
  FutureOr<V?> find({bool shouldRemove = true}) async {
    String? data = spf.getString(cacheKey);
    if (data == null || data.isEmpty) return null;
    try {
      dynamic map = jsonDecode(data);
      dynamic jsonValue = map['value'];
      if (jsonValue == null) return null;

      int time = map['time'] ?? 0;
      int nowMs = DateTime.now().millisecondsSinceEpoch;
      int deadMs = time + maxCacheMs;
      if (nowMs > deadMs && shouldRemove) {
        await remove();
        return null;
      }
      List<dynamic> v = jsonDecode(jsonValue);
      return convertor(v);
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  FutureOr<bool> save(V po) async {
    String data = json.encode(TimeoutPo.value(json.encode(po)));
    return spf.setString(cacheKey, data);
  }

  @override
  FutureOr<bool> remove() {
    return spf.remove(cacheKey);
  }
}

class TimeoutPo extends Po {
  final int time;
  final String data;

  TimeoutPo.value(this.data) : time = DateTime.now().millisecondsSinceEpoch;

  TimeoutPo({
    required this.time,
    required this.data,
  });

  @override
  Map<String, dynamic> toJson() => {
        'time': time,
        'value': data,
      };

  factory TimeoutPo.fromJson(dynamic map) {
    return TimeoutPo(
      time: map['time'],
      data: map['value'],
    );
  }
}
