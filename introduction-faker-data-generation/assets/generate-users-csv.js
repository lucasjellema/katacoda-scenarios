const faker = require('faker');
const fs = require('fs')
const { Parser } = require('json2csv');

function generateUsers() {

  let users = []

  for (let id = 1; id <= 100; id++) {

    let firstName = faker.name.firstName();
    let lastName = faker.name.lastName();
    let email = faker.internet.email();

    users.push({
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email
    });
  }

  return { "data": users }
}

let dataObj = generateUsers();

// prepare json2csv
const opts = { "quote": "'" }; // see: https://www.npmjs.com/package/json2csv 
const parser = new Parser(opts);
const csv = parser.parse(dataObj.data);

fs.writeFileSync('users.csv', csv);