import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:io';

final String baseUrl = Platform.isAndroid
    ? 'http://10.0.2.2:4000'
    : 'http://localhost:4000';

final HttpLink httpLink = HttpLink(baseUrl);

GraphQLClient getGraphQLClient() {
  return GraphQLClient(cache: GraphQLCache(), link: httpLink);
}
