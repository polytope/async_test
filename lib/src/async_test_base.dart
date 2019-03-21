import 'dart:async';

typedef void DoneFn();
typedef void AsyncBody(DoneFn done);
typedef Future<Null> AsyncVoid();

/// This allows for completely async tests, where the test does not end, until
/// the finisher is called.
///
/// The [body] should be the same as for a normal test. That is, the same as you
/// would put in for body in `test("description", body)`.
///
/// The following example demonstrates a test that only resolves after the
/// second emission from `obs`:
///
/// ```dart
/// test("Async test", async((DoneFn done) {
///   Observable obs = Observable.fromIterable([1, 2);
///
///   obs.listen((int res) {
///     switch(res) {
///       case 0:
///         expect(res, 0);
///         break;
///       case 1:
///         expect(res, 1);
///         done();
///         break;
///     }
///   });
/// }));
///  ```
AsyncVoid async(AsyncBody body) {
  final Completer<bool> done = Completer<bool>();

  return () async {
    // Run the normal test asynchronously
    // ignore: unawaited_futures
    () async {
      body(() => done.complete(true));
    }();

    // Await the completion call
    await done.future;
  };
}
