import 'package:async_test/async_test.dart';
import 'package:test_api/test_api.dart';

main() {
  test("Async test", async((DoneFn done) {
    Stream.fromIterable([1, 2]).listen((int res) {
      switch(res) {
        case 0:
          expect(res, 0);
          break;
        case 1:
          expect(res, 1);
          done();
          break;
      }
    });
  }));
}
