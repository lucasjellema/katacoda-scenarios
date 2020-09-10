Generate Data generic and locale specific

## Faking random values
The faker allows to generate random values, such as integers, uuids, or words.

`node random.js`{{execute}}

## Faking locale data
The faker supports localized data to some extent. Note that the locales are finished to various levels.

`node locale-faker.js`{{execute}}

The example generates fake data in Russian language.

## Generate Users Data in JSON file
This script generates one hundred user objects and writes them to a JSON file called users.json.

`node generate-users-file`{{execute}}

Check the file that was produced: `cat users.json`{{execute}}

Note: every time you rerun this statement, the file is generated with fresh contents.
