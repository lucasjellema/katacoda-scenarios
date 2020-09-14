const faker = require('faker');

let firstName = faker.name.firstName();
let lastName = faker.name.lastName();

let jobTitle = faker.name.jobTitle();
let prefix = faker.name.prefix(); 
let suffix = faker.name.suffix();
let jobArea = faker.name.jobArea();

let phone = faker.phone.phoneNumber();

console.log(`Employee: ${prefix} ${firstName} ${lastName} ${suffix}`);
console.log(`Job title: ${jobTitle}`);
console.log(`Job area: ${jobArea}`);
console.log(`Phone: ${phone}`);

faker.locale = "nl";
firstName = faker.name.firstName();
lastName = faker.name.lastName();

console.log(`Dutch Name: ${firstName} ${lastName}`);

let month = faker.date.month();
let weekday = faker.date.weekday();

console.log(month);
console.log(weekday);


