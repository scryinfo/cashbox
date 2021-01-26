import 'package:services/services.dart';
import 'package:test/test.dart';

void main() {
  test("AppPlatformType", () {
    for (var it in AppPlatformType.values) {
      expect(it, it.toEnumString().toAppPlatformType());
    }
  });
}
