# First steps - really simple

Here we first look at some of the examples I have gathered from other resources:

Let’s start by taking a look at the simplest filter of all which incidentally is one of the most useful and frequently used features of jq:

`echo '{"fruit":{"name":"apple","color":"green","price":1.20}}' | jq '.'`{{execute}}
In this example, we echo a simple JSON string and pipe it directly into our jq command. Then, we use the identity filter ‘.’ which takes the input and produces it unchanged as output with the caveat that by default jq pretty-prints all output.

Slightly more interesting would be to use an expression to extract a particular property - the color of the fruit object - from the JSON document:

`echo '{"fruit":{"name":"apple","color":"green","price":1.20}}' | jq '.fruit | .color'`{{execute}}

jq can work with arrays just as easily as with plain or nested objects.

`basket='[
  {
    "name": "apple",
    "color": "green",
    "price": 1.2
  },
  {
    "name": "banana",
    "color": "yellow",
    "price": 0.5
  },
  {
    "name": "kiwi",
    "color": "green",
    "price": 1.25
  }
]'`{{execute}}

List the names of the fruits in the basket:

`echo $basket | jq '.[].name '`{{execute}}

Additional functions in jq can be applied to arrays, such as *unique* :
`echo $basket | jq 'map(.color) | unique'`{{execute}} 
