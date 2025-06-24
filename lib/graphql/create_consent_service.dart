import 'package:demo_app/services/secure_storage_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'client.dart';
import 'mutations.dart';

Future<Map<String, dynamic>?> createConsent({
  required String fullName,
  required String email,
}) async {
  final client = getGraphQLClient();

  // Retrieve stored auth token
  final String? token = await SecureStorageService.getAuthToken();

  if (token == null) {
    return null;
  }

  final MutationOptions options = MutationOptions(
    document: gql(createConsentMutation),
    variables: {
      'input': {'fullName': fullName, 'email': email},
    },
    context: Context().withEntry<HttpLinkHeaders>(
      HttpLinkHeaders(headers: {'Authorization': 'Bearer $token'}),
    ),
  );

  final QueryResult result = await client.mutate(options);

  if (result.hasException) {
    return null;
  }

  final data = result.data?['createConsent'];

  return data;
}
