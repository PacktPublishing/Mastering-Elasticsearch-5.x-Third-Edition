#Example of tagging errors which occurs during ingestion of documents using _ingest API, within same document and index
#Step 1: Define a pipeline that renames the "category" field in the processed document to "databases". If the document does not contain the category field, the processor attaches an error message to the document for later analysis within Elasticsearch.
curl -XPUT "http://localhost:9200/_ingest/pipeline/pipeline1" -d'
{
  "description" : "my first pipeline with handled exceptions",
  "processors" : [
    {
      "rename" : {
        "field" : "name",
        "target_field" : "technology_name",
        "on_failure" : [
          {
            "set" : {
              "field" : "error",
              "value" : "field \"name\" does not exist, cannot rename to \"technology_name\""
            }
          }
        ]
      }
    }
  ]}'

#Step 2: Index a document using this pipeline. Please note that this document does not contain a name field but this document will be indexed.
curl -XPOST "http://localhost:9200/my_index/doc/1?pipeline=pipeline1" -d'
{
  "message": "learning ingest APIs"
}'

#Step 3: Retrieve the above indexed document from Elasticsearch and you will see that it contains an additional field error with our custom error message contained as a value. The expected output of the GET request will look like below commeted lines:
#{
#   "_index": "my_index",
#   "_type": "doc",
#   "_id": "1",
#   "_version": 1,
#   "found": true,
#   "_source": {
#      "message": "learning ingest APIs",
#      "error": "field \"name\" does not exist, cannot rename to \"technology_name\""
#   }
#}
curl -XGET "http://localhost:9200/my_index/doc/1"

