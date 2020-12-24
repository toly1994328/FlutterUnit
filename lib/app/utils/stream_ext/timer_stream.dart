import 'dart:async';

/// Emits the given value after a specified amount of time.
///
/// ### Example
///
///     TimerStream('hi', Duration(minutes: 1))
///         .listen((i) => print(i)); // print 'hi' after 1 minute
class TimerStream<T> extends Stream<T> {
  final StreamController<T> _controller;

  /// Constructs a [Stream] which emits [value] after the specified [Duration].
  TimerStream(T value, Duration duration)
      : _controller = _buildController(value, duration);

  @override
  StreamSubscription<T> listen(void Function(T event) onData,
      {Function onError, void Function() onDone, bool cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  static StreamController<T> _buildController<T>(T value, Duration duration) {
    if (duration == null) {
      throw ArgumentError('duration cannot be null');
    }

    StreamSubscription<T> subscription;
    StreamController<T> controller;

    controller = StreamController(
      sync: true,
      onListen: () {
        subscription =
            Stream.fromFuture(Future.delayed(duration, () => value)).listen(
              controller.add,
              onError: controller.addError,
              onDone: () {
                if (!controller.isClosed) {
                  controller.close();
                }
              },
            );
      },
      onPause: ([Future<dynamic> resumeSignal]) =>
          subscription.pause(resumeSignal),
      onResume: () => subscription.resume(),
      onCancel: () => subscription.cancel(),
    );
    return controller;
  }
}
