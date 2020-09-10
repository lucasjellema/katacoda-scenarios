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

## Generate Sample Data in CSV files

The faker module itself does not produce either JSON or CSV. We have seen how faker is used to produce strings that are used to create objects that can be stringified to JSON format that is written to file. Taking data objects and serializing them as CSV is not a big step either. Many modules support this operation. See for example in generate-users-csv.js, using npm module json2csv ([www.npmjs.com/package/json2csv](https://www.npmjs.com/package/json2csv)) .

`npm install json2csv --save`{{execute}}


```
node generate-users-csv
cat users.csv
ls -l users.csv
```{{execute}}

By all means, execute these statements multiple times. Every time, the file will be quite different.