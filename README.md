# Revlet Review Service

## Overview
The review service is responsible for handling API requests to create and manage property reviews. The reviews are stored in the same table as the properties.

## GraphQL
The service will define an AWS AppSync resource capable of handling GraphQL requests from the client.

Following this, the service will forward the requests to a dynamodb table.

### Mapping Template
When using App Sync, we need some form of mapping to convert the graphql schema into an object that DynamoDB can trust and process.


### Authenticating Calls
AppSync allows for authentication through Cognito and can validate user groups and permissions