const faker = require('faker');

faker.locale = "nl";
// use faker moustache expressions as placeholders for generated data
const fakePerson = { "name"      :"{{name.firstName}} {{name.lastName}}"
                   , "address"   : { "street" :"{{address.streetName}} {{random.number}}"
                                   , "city"   :"{{address.city}}"
                                   , "country":"{{address.country}}"
                                   }
                   , "birthdate" : "{{date.past}}"
                   }
// feed stringified representation of JSON object to faker.fake to replace moustache expressions with generated data                   
const person = JSON.parse( faker.fake( JSON.stringify(fakePerson)))
console.log(JSON.stringify(person))


