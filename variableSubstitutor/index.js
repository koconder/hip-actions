var core = require('@actions/core');
const yaml = require('js-yaml');
var jp = require('jsonpath');
const fs = require('fs');
var filename = ".argocd.yaml";
var keyToReplace = "$.spec.source.helm.parameters[0].value";
var valueToReplace = "random-name";
let config = {};
try {
    config = yaml.load(fs.readFileSync(filename, 'utf8'));
} catch (e) {
    console.log(e);
}

var filesInput = core.getInput("files", { required: true });
var files = filesInput.split(",");

console.log("Substituting variables in the file: ", files);
// var jsonString = JSON.stringify(config);

// var obj = JSON.parse(jsonString);
// //config.metadata.name = "newvalue";

// var result = jp.query(obj, keyToReplace);

// if(result){
//      result2 = jp.value(obj, keyToReplace, valueToReplace);
//  }
// console.log(result);

// console.log(result2);

// // console.log(jsonString);

// // console.log(config.spec.source.helm.parameters[0].value);


// //fs.writeFileSync(filename, yaml.dump(config));