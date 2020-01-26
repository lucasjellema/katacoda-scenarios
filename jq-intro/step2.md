# Explore JSON documents loaded from afar

Load JSON data into variable

`countries=$(curl https://restcountries.eu/rest/v2/all)`{{execute}} 

Get details on The Netherlands: 

`nl=$(echo $countries | jq -r --arg countryAlpha2Code "NL" '. | map(select(."alpha2Code" == $countryAlpha2Code)) | .[0] | .')`{{execute}} 

Note how input parameter *countryAlpha2Code* is defined and how it is set as "NL" and how it is subsequently used in the comparison in the *select* in the *map* operator. Variable $nl is now defined with a JSON document describing The Netherlands as its contents. The `-r` switch is used to request raw output from jq. 

Show the contents of variable `$nl`:
`echo $nl`{{execute}}

Get the Dutch capital:
`echo $nl | jq '.| .capital'`{{execute}}

We could have gotten their in a more direct fashion of course:
`echo $countries | jq -r --arg countryAlpha2Code "NL" '. | map(select(."alpha2Code" == $countryAlpha2Code)) | .[0] | .capital'`{{execute}} 

To get a list of all European capitals from the JSON countries document:
`echo $countries | jq -r --arg region "Europe" '. | map(select(."region" == $region)) | .[] | .capital'`{{execute}}
