import 'package:flutter_test/flutter_test.dart';
import 'package:simpleapp/model/API/user_api.dart';

void main() {
  
  test('fetch all user Regress', () async {
    final user = await UserAPI().getUser(
      pages: 1, 
      perPages: 20
    );
    expect(user.length, 12);
    expect(user[0].firstName, 'George');
  });
}