const faker = require('faker/locale/ru');

let firstName = faker.name.firstName();
let lastName = faker.name.lastName();

console.log(`Pаботник: ${firstName} ${lastName}`);

let month = faker.date.month();
let recentDate = faker.date.recent();
let rectentDate = faker.date.weekday();

console.log(month);
console.log(recentDate);
console.log(rectentDate);