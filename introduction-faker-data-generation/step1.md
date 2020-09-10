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
curl http://faker.hook.io?property=telephone.phoneNumber
echo Some Sentence
curl http://faker.hook.io?property=hacker.phrase
echo Bank Account
curl http://faker.hook.io?property=finance.account
```{{execute}}


** Get going locally and programmatically

Setting up faker.js
First, we install faker.js.

`node -v`{{execute}}

We initiate a new Node application.

`npm init -y`{{execute}}

Install the Faker NPM module
`npm i faker`{{execute}}

Now run a simple example of a small Node application that uses Faker to generate some name data:
`node names.js`{{execute}}