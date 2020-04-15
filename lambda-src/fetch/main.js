var AWS = require('aws-sdk');

async function lambdaHandler(event, context) {
  var dynamo = new AWS.DynamoDB({region: 'us-east-1'});
  var app    = event.app;
  
  var params = {
    TableName: 'login',
    Key: {
      'app': {S: app}
    }
  };
  
  var data = await dynamo.getItem(params).promise();
  return {
    statusCode: "200",
    body: data
  }
}
exports.handler = lambdaHandler;
