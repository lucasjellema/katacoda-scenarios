Generate Data generic and locale specific

## Faking random values
The faker allows to generate random values, such as integers, uuids, or words.

`node random.js`{{execute}}

## Faking locale data
The faker supports localized data to some extent. Note that the locales are finished to various levels.

`node locale-faker.js`{{execute}}

The example generates fake data in Russian language.

### Localization
faker.js has support for multiple localities.

The default language locale is set to English.

Setting a new locale is simple:

for example: sets locale to *de*
`faker.locale = "de";`

supported locales:
az
cz
de
de_AT
de_CH
en
en_AU
en_BORK
en_CA
en_GB
en_IE
en_IND
en_US
en_au_ocker
es
es_MX
fa
fr
fr_CA
ge
id_ID
it
ja
ko
nb_NO
nep
nl
pl
pt_BR
ru
sk
sv
tr
uk
vi
zh_CN
zh_TW

As of version v3.0.0 faker.js supports incremental loading of locales. By default, requiring faker will include all locale data. In a production environment, you may only want to include the locale data for a specific set of locales.
```
// loads only de locale
var faker = require('faker/locale/de');
```

### Setting a randomness seed
If you want consistent results, you can set your own seed:

```
faker.seed(123);
var firstRandom = faker.random.number();
// Setting the seed again resets the sequence.
faker.seed(123);
var secondRandom = faker.random.number();
console.log(firstRandom === secondRandom);
```