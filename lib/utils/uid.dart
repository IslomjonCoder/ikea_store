import 'package:uuid/uuid.dart';

class UidGenerator {
  static final Uuid _uid = Uuid();

  static generateUID() => _uid.v4();
}
