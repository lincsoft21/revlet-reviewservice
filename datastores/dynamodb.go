package datastores

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
)


type DynamoClient struct {
	client *dynamo.DynamoDB
}

func NewDynamoClient() {
	clientConnection := dynamodb.New(session.Must(session.NewSession(&aws.Config{
		Region: aws.String("eu-west-2"),
	})))

	return DynamoClient{
		client: clientConnection,
	}
}

// const TABLE_NAME="revlet-propertyservice-dev-db"

func (dc DynamoClient) CreateItem(p PropertyRequest) error {
	_, err := dynamo.PutItem(&dynamodb.PutItemInput{
		Item: map[string]*dynamodb.AttributeValue{
			"ID": {
				S: aws.String(p.ItemID),
			},
		},
	})

	return err
}