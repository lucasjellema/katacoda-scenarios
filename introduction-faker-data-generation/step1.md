Faker has a live running demo at http://faker.hook.io. You can use this demo for example from *curl* commands to get a feel for some of its capabilities

```
echo German Surname
curl http://faker.hook.io?property=name.findName&locale=de
echo Email Address
curl http://faker.hook.io?property=internet.email
echo Recent Date
curl http://faker.hook.io?property=date.recent
echo Random Text
curl http://faker.hook.io?property=lorem.paragraph
echo Telephone Number
curl http://faker.hook.io?property=phone.phoneNumber
echo Some Sentence
curl http://faker.hook.io?property=hacker.phrase
echo Bank Account
curl http://faker.hook.io?property=finance.account
echo List of all options
curl http://faker.hook.io?property=x
```{{execute}}




# Get going locally - with CLI

Faker CLI
The faker-cli is a Node module, which is a wrapper over the faker.js. It allows to generate fake data from a command line tool.

Install the faker-cli module.
`npm install -g faker-cli`{{execute}}

We can use the CLI as follows:

`faker-cli -d future`{{execute}}
The -d switch indicates the domain (d: date, n:name, p: phone, f: finance), follow by the property in that domain.

```
faker-cli -d recent
faker-cli -n firstName
faker-cli -n lastName
```{{execute}}

Try again executing the above statements - and find that the result is different each time.


# Get going programmatically from Node applications

Setting up faker.js
First, we install faker.js. Check if node is installed and if so which version:

`node -v`{{execute}}

We initiate a new Node application.

`npm init -y`{{execute}}

Install the Faker NPM module:

`npm i faker`{{execute}}

Now run a simple example of a small Node application that uses Faker to generate some name data. The example creates a random first name, last name, job title, name prefix and suffix, job area, and phone number:

`node names.js`{{execute}}

And run it again to see that this time different results are produced:

`node names.js`{{execute}}

And feel free to run it a few times more.

Check the contents of *names.js* in the IDE or with `cat names.js`{{execute}}. 

The JavaScript code requires the *faker* module. Then it uses this module by asking it for specific properties in specific domains. In this case, the domain is *name* and the properties are *firstName, lastName, jobTitle, prefix, suffix and jobArea.

In `names-extended.js` we make use of a few other domains supported by faker: vehicle, finance and git. Just for fun really.

`node names-extended.js`{{execute}}

In *fake-expressions.js* we make use of the *faker.fake()* function that interprets strings with moustache notations and replaces expressions with generated data:
`faker.fake ("{{name.prefix}} {{name.firstName}} {{name.lastName}} {{name.suffix}}")`
Using such expressions, we can generate documents with fake data in many different formats.


Check file *dates.js* for similar fake data generation in the *date* domain - using properties futureDate, recentDate and weekday:

`node dates.js`{{execute}}

And feel free to run it a few times more.

Check the contents of *dates.js* in the IDE or with `cat dates.js`{{execute}}.