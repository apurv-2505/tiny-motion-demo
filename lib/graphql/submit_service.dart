import 'package:demo_app/services/secure_storage_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'client.dart';
import 'mutations.dart';

Future<Map<String, dynamic>?> submitVideo({
  required String sessionId,
  required String videoBase64,
}) async {
  final client = getGraphQLClient();

  // Retrieve stored auth token
  final String? token = await SecureStorageService.getAuthToken();

  if (token == null) {
    return null;
  }

  final MutationOptions options = MutationOptions(
    document: gql(submitMutation),
    variables: {
      'input': {'sessionId': sessionId, 'videoBase64': videoBase64},
    },
    context: Context().withEntry<HttpLinkHeaders>(
      HttpLinkHeaders(headers: {'Authorization': 'Bearer $token'}),
    ),
  );

  final QueryResult result = await client.mutate(options);

  if (result.hasException) {
    return null;
  }

  final data = result.data?['submit'];

  return data;
}
