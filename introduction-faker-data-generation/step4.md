Exploring code

The values returned by the various faker domain data generators are defined in the locales JavaScript files that live under node-modules/faker/lib/locales. For each supported locale, a language and region specific instance of a library file is defined that contains the localized values returned by the corresponding module. 

![](assets/faker-locales.png)

For example file *faker/lib/locales/de/name/first_name.js* contains the German set of first names that are used in module *faker/lib/name*, overriding the default values in *faker/lib/locales/en/name/first_name.js* in case the local is set to *de*

## Extending & Complementing

You can of course create enhancements to faker and send a merge request to the maintainers of the project. And you should.

For quick finetuning of what faker does, you can use other means. Such as overriding functions in the original faker module and adding such functions.
<pre>
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
</pre>

Check out the contents of `custom-faker.js` and `names-custom.js` that uses the overriding actions of the custom faker. 

Then run 
`node names-custom.js`{{execute}}

for an example of how you can tune and complement the actions of the faker module.