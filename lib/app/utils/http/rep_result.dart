
class RepResult {
  var data;
  bool status;
  int code;
  String msg;

  RepResult(this.data, this.status, this.code, {this.msg=""});

  @override
  String toString() {
    return 'RepResult{data: $data, result: $status, code: $code, msg: $msg}';
  }
}

//class RepResult<T> {
//  T data;
//  bool status;
//  int code;
//
//  RepResult(this.data, this.status, this.code);
//
//  @override
//  String toString() {
//    return 'RepResult{data: $data, status: $status, code:$code}';
//  }
//
//}