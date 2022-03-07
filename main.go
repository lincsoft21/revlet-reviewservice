package main

import (
	"context"
	"errors"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

var dbClient *dynamodb.DynamoDB


type appSyncRequest struct {
	Field     string       `json:"field"`
	UserId    string       `json:"user_id"`
	Arguments argumentsObj `json:"arguments"`
}

type argumentsObj struct {
	Input models.PropertyRequest `json:"input"`
}

func init() {
	dbClient = datastores.NewDynamoClient()
}

// Get event object from appsync
func Handler(ctx context.Context, req appSyncRequest) (interface{}, error) {
	var res datastore.PropertyResponse
	var err error

	switch req.Field {
	case "getProperties":
		err = handlers.getProperties(&req &res)
	default:
		errorMsg := "Unknown GraphQL Field" + req.Field
		err = errors.New(errorMsg)
	}

	if err != nil {
		res.Error.Message = err.Error()
	}

	if res.Properties == nil {
		res.Properties = []models.Properties()
	}

	return res, nil
}
 
func main() {
	lambda.Start(Handler)
}