# Playing a little more with jq 
JSON can be read from files and variables. The output from jq can also be captured into variables and written to files.

`echo '[
{
"roll": 3,
"name": "Michael",
"batch": 29,
"department": "Frontend Development"
},
{
"roll": 55,
"name": "Lisa",
"batch": 34,
"department": "Integration Specialists"
},
{
"roll": 12,
"name": "Maarten",
"batch": 22,
"department": "Dutch Architecture"
}
]' > students.json`{{execute}}

Check the contents of the file:
`cat students.json`{{execute}}

To extract the department values from the file:
`jq '.[] | .department' students.json`{{execute}}

which is equivalent to:
`cat students.json | jq '.[] | .department'`{{execute}}

If you want to read two or more object values from JSON data then mention the object names by separating comma (,) in the jq command. The following command will retrieve the values of name and department keys.

`jq '.[] | .name, .department' students.json`{{execute}}

jq command is used not only for reading JSON data but also to display data by removing a particular key. The next command shows the Students objects minus the *batch* and *roll* properties:
`jq 'map(del(.batch, .roll))' students.json`{{execute}} 

