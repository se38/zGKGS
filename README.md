# zGKGS
The [Google Knowledge Graph Search](https://developers.google.com/knowledge-graph/) API for ABAP

See [Blog post on SAP Community Network](http://scn.sap.com/community/abap/connectivity/blog/2016/01/08/google-knowledge-graph-search-api-schemaorg-and-json-ld)
 
## Required Packages
* [SchemA](https://github.com/se38/SchemA) - The schema.org ABAP Framework

## Installation 
* Clone this repository with [abapGIT](https://github.com/larshp/abapGit) into a package of your choice. Activate all objects despite the fact that there are errors (dependences).
* [Get an API key](https://developers.google.com/knowledge-graph) - How to? Follow the link
* call the API in your browser (for example https://kgsearch.googleapis.com/v1/entities:search?query=chuck%20norris&key=YourAPIkeyHere )
* download all three SSL certificates (the whole certification path) from the API response
* install these certificates into transaction STRUST (the SSL client) (will be described in detail the wiki later)

## Usage
see demo report (wiki to follow)

## License
This software is published under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)
