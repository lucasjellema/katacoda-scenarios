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
console.log(`Vehicle: ${faker.vehicle.model()} ${faker.vehicle.type()}`)
console.log(`Credit Card: ${faker.finance.creditCardNumber()}`)
console.log(`IBAN: ${faker.finance.iban()}`)
console.log(`Git Commit: ${faker.git.commitEntry()}`)


