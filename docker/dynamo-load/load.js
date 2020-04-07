// fs       - allows for stream to be created
// readline - allows for events on stream from fs 
const fs       = require('fs');
const readline = require('readline');
const AWS      = require('aws-sdk');

// process command line args
var args        = process.argv.slice(2);
var targetCSV   = args[0];
var targetTable = args[1];

var dynamodb = new AWS.DynamoDB({region: "us-east-1"});

// create stream from csv
const readInterface = readline.createInterface({
  input: fs.createReadStream(`./${targetCSV}`)
});

// init helper vars
var lineCounter = 0;
var colOne      = '';
var colTwo      = '';

// on stream read of new line
readInterface.on('line', (line) => {
  lineCounter++;

  // handle first line (header)
  if(lineCounter == 1) {
    var headerArr = line.split(',');
    colOne        = headerArr[0];
    colTwo        = headerArr[1];
  }

  // data
  else {
    var passArr   = line.split(',');
    var app       = passArr[0];
    var pass      = passArr[1];
    var putParams = {Item:{[colOne]:{S: app}, [colTwo]:{S: pass}}, TableName: targetTable};
    dynamodb.putItem(putParams, (err, data) => {
      if (err) console.log(err, err.stack);
      else console.log(data);
    });
  }
});
