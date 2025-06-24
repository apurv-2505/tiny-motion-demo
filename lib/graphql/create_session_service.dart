import 'package:demo_app/services/secure_storage_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'client.dart';
import 'mutations.dart';

Future<Map<String, dynamic>?> createSession({
  required String childFullName,
  required String childNHINumber,
  required String childDOB,
  required String motherDueDate,
}) async {
  final client = getGraphQLClient();

  // Retrieve stored auth token
  final String? token = await SecureStorageService.getAuthToken();

  if (token == null) {
    return null;
  }

  final MutationOptions options = MutationOptions(
    document: gql(createSessionMutation),
    variables: {
      'input': {
        'childFullName': childFullName,
        'childNHINumber': childNHINumber,
        'childDOB': childDOB,
        'motherDueDate': motherDueDate,
      },
    },
    context: Context().withEntry<HttpLinkHeaders>(
      HttpLinkHeaders(headers: {'Authorization': 'Bearer $token'}),
    ),
  );

  final QueryResult result = await client.mutate(options);

  if (result.hasException) {
    return null;
  }

  final data = result.data?['createSession'];

  return data;
}
