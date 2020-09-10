const faker = require('faker');

let number = faker.random.number();
console.log(number);

let uuid = faker.random.uuid();
console.log(uuid);

let word = faker.random.word();
console.log(word);

let words = faker.random.words(6);
console.log(words);