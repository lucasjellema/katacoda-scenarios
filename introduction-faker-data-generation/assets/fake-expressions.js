const faker = require('faker');
console.log(`Employee: ${faker.fake ("{{name.prefix}} {{name.firstName}} {{name.lastName}} {{name.suffix}}")}`);

const employee = JSON.parse( 
    faker.fake (`{"name":"{{name.prefix}}", "firstName": "{{name.firstName}}", "lastName": "{{name.lastName}}", "suffix": "{{name.suffix}}"} `) ) 
employee.birthday = faker.date.recent()

console.log(`Employee: ${JSON.stringify(employee)}`)
