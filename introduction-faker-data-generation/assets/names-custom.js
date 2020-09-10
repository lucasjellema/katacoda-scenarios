const faker = require('./custom-faker.js');

let firstName = faker.name.firstName();
let lastName = faker.name.lastName();

let jobTitle = faker.name.jobTitle();
let prefix = faker.name.prefix(); 
let suffix = faker.name.suffix();

console.log(`Employee: ${prefix} ${firstName} ${lastName} ${suffix}`);
console.log(`Job title: ${jobTitle}`);

console.log(`Hobby: ${faker.timeOff.hobbies()}`);
console.log(`Vehicle Make: ${faker.vehicle.manufacturer()}`);



