#Validating expensive queries before execution

#Example of using _validate REST endpoint for validating the queries without executing them.

#Step 1: First of all lets create and index some sample documents inside it:

curl -XPUT "http://localhost:9200/elasticsearch_books/books/_bulk?refresh" -d'
{"index":{"_id":1}}
{"author" : "d_bharvi", "publishing_date" : "2009-11-15T14:12:12", "title" : "Elasticsearch Essentials"}
{"index":{"_id":2}}
{"author" : "d_bharvi", "publishing_date" : "2009-11-15T14:12:13", "title" : "Mastering Elasticsearch 5.0"}
'

#Step 2: Build a simple query and validate it against our newly created index as follows.
curl -XGET "http://localhost:9200/elasticsearch_books/books/_validate/query?explain=true" -d'
{
  "query" : {
    "bool" : {
      "must" : [{
       "query_string": {
          "default_field": "title",
          "query": "elasticsearch AND essentials"
       }
      }],
      "filter" : {
        "term" : { "author" : "d_bharvi" }
      }
    }
  }
}'

#Step 3: Execute another query, in which we are going to match a string against a date field and it will validate that this query has bugs
curl -XGET "http://localhost:9200/elasticsearch_books/books/_validate/query?explain=true" -d'
{
   "query": {
      "bool": {
         "must": [
            {
               "query_string": {
                  "default_field": "publishing_date",
                  "query": "elasticsearch AND essentials"
               }
            }
         ],
         "filter": {
            "term": {
               "author": "d_bharvi"
            }
         }
      }
   }
}'


