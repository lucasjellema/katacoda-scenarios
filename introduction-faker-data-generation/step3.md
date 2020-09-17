Generate JSON and CSV documents

## Generate Users Data in JSON file
This script generates one hundred user objects and writes them to a JSON file called users.json.

`node generate-users-file`{{execute}}

Check the file that was produced: 
```
cat users.json
ls -l users.json
```{{execute}}

Note: every time you rerun this statement, the file is generated with fresh contents.

## Generated a Complex, Nested Object
Faker does not itself produce complex objects - most of its functions produce individual data elements. However, producing a complexm, nested objects with nested collections and data from various locaes is not all that hard. Take a look at the contents of file *generateCompanyObject.js*:
`cat generateCompanyObject.js`{{execute}}
It shows a JSON document structure using calls to faker.js to produce random data elements. Using this approach it is simple to generate complex data structures, that can look like this:
```
{
    "name": "Beahan, Cassin and Emard",
    "country": "Guam",
    "departments": [
        {
            "name": "Movies",
            "location": "Mooreland (Tanzania)",
            "employees": [
                {
                    "name": "Levi Daniel",
                    "job": "Customer Paradigm Supervisor",
                    "hiredate": "2016-03-05",
                    "salary": 443
                },
                {
                    "name": "Lachlan Stark",
                    "job": "Internal Directives Planner",
                    "hiredate": "2015-04-07",
                    "salary": 83
                },
                {
                    "name": "Daniel Harris",
                    "job": "Regional Marketing Facilitator",
                    "hiredate": "2016-01-29",
                    "salary": 261
                }
            ]
        }
    ]
}
```
To execute this file, run this command:
```
node generateCompanyObject.js
cat companyDataSet.json
```{{execute}}

## Generate Sample Data in CSV files

The faker module itself does not produce either JSON or CSV. We have seen how faker is used to produce strings that are used to create objects that can be stringified to JSON format that is written to file. Taking data objects and serializing them as CSV is not a big step either. Many modules support this operation. See for example in generate-users-csv.js, using npm module json2csv ([www.npmjs.com/package/json2csv](https://www.npmjs.com/package/json2csv)) .

`npm install json2csv --save`{{execute}}


```
node generate-users-csv
cat users.csv
ls -l users.csv
```{{execute}}

By all means, execute these statements multiple times. Every time, the file will be quite different.