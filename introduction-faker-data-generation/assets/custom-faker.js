const faker = require('faker');
// delete the function you would like to override
delete faker['name.jobTitle'];
 
// add new functional with the same name as deleted function
faker.name.jobTitle = function(str){
    return "Coder"
}

faker.timeOff = {} 
faker.timeOff.hobbies = function (str) {
    const hobbies = ["Tennis", "Golf", "Fishing","Hiking","Cooking"]
    return faker.random.arrayElement(hobbies)
}
// re-export the module for changes to take effect
module.exports = faker
