#Example of using grok processor with _ingest API
#Step 1: Define a pipleine
curl -XPUT "http://localhost:9200/_ingest/pipeline/grok-pipeline" -d'
{
   "description": "my pipeline for extracting info from logs",
   "processors": [
      {
         "grok": {
            "field": "message",
            "patterns": [
               "%{IP:client} %{WORD:method} %{URIPATHPARAM:req} %{NUMBER:bytes} %{NUMBER:duration}"
            ]
         }
      },
      {
         "convert": {
            "field": "duration",
            "type": "integer"
         }
      }
   ]
}'

#Step 2: Index a document 
curl -XPOST "http://localhost:9200/logs/doc/1?pipeline=grok-pipeline" -d'
{
  "message": "127.0.0.1 POST /fetch_docs 200 10"
}'

#Step 3: Retrieve the document from Elasticsearch to see the processed results
curl -XGET "http://localhost:9200/logs/doc/1"

#Example of defining custom grok processors using pattern_definition option and test it with _simulate API
curl -XPOST "http://localhost:9200/_ingest/pipeline/_simulate" -d'
{
  "pipeline": {
  "description" : "parse custom patterns",
  "processors": [
    {
      "grok": {
        "field": "message",
        "patterns": ["%{LOVE:hobbies} about %{TOPIC:topic}"],
        "pattern_definitions" : {
          "LOVE" : "reading",
          "TOPIC" : "databases"
        }
      }
    }
  ]
},
"docs":[
  {
    "_source": {
      "message": "I like reading about databases"
    }
  }
  ]
}'
