import 'package:flutter_riverpod/flutter_riverpod.dart';

final formStateProvider = StateProvider<Map<String, String>>(
  (ref) => {
    'childFullName': '',
    'childNHINumber': '',
    'childDOB': '',
    'motherDueDate': '',
    'sessionId': '',
  },
);
final formValidityProvider = StateProvider<bool>((ref) => true);
