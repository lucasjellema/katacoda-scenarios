const faker = require('faker');
// delete the function you would like to override
delete faker['name.jobTitle'];
 
// add new function with the same name as deleted function
faker.name.jobTitle = function(str){
    return "Coder"
}

// create reference to original function, then delete and replace it
const originalManufacturer = faker.vehicle.manufacturer
delete faker['vehicle.manufacturer']
// create implementation of overriding function - using the reference to the original function
faker.vehicle.manufacturer = function(){
    const m = originalManufacturer()
    return m + " " + faker.random.arrayElement(["Inc", "Cars & Co", "on Wheels", "Vrrroommm", "Ltd"])
}

faker.timeOff = {} 
faker.timeOff.hobbies = function (str) {
    const hobbies = ["Tennis", "Golf", "Fishing","Hiking","Cooking"]
    return faker.random.arrayElement(hobbies)
}
// re-export the module for changes to take effect
module.exports = faker
