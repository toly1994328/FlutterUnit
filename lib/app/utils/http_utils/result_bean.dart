class ResultBean<T> {
  T data;
  bool status;
  String msg;

  ResultBean({this.data, this.status, this.msg});

  @override
  String toString() {
    return 'RepResult{data: $data, status: $status, msg:$msg}';
  }

  static ResultBean<T> fromData<T>(dynamic data) {
    return ResultBean<T>(
      msg: data['msg'],
      data: data['data'],
      status: data['status'],
    );
  }

  static ResultBean<T> error<T>(String msg) {
    return ResultBean(
      msg: msg,
      data: null,
      status: false,
    );
  }

  static ResultBean<T> ok<T>(T data) {
    return ResultBean(
      msg: '请求成功',
      data: data,
      status: true,
    );
  }
}
