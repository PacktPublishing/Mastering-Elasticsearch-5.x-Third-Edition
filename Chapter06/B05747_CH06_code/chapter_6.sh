#command for creating documents index with 2 shards and 0 replica
curl -XPUT 'localhost:9200/documents' -d '{
  "settings": {
    "number_of_replicas": 0,
    "number_of_shards": 2
  }
}'

#indexing sample documents
curl -XPUT localhost:9200/documents/doc/1 -d '{ "title" : "Document No. 1" }'
curl -XPUT localhost:9200/documents/doc/2 -d '{ "title" : "Document No. 2" }'
curl -XPUT localhost:9200/documents/doc/3 -d '{ "title" : "Document No. 3" }'
curl -XPUT localhost:9200/documents/doc/4 -d '{ "title" : "Document No. 4" }'

#Get shards information
curl -XGET localhost:9200/_cat/shards?v

#Delete by query example
curl -XPOST "http://localhost:9200/documents/_delete_by_query" -d'
{"query": {"match_all": {}}}'

#Indexing documents with custom routing
curl -XPUT localhost:9200/documents/doc/1?routing=A -d '{ "title" : "Document No. 1" }'
curl -XPUT localhost:9200/documents/doc/2?routing=B -d '{ "title" : "Document No. 2" }'
curl -XPUT localhost:9200/documents/doc/3?routing=A -d '{ "title" : "Document No. 3" }'
curl -XPUT localhost:9200/documents/doc/4?routing=A -d '{ "title" : "Document No. 4" }'

#Query documents with custom routing
curl -XGET 'localhost:9200/documents/_search?pretty&q=*&routing=A'

#Query documents with custom routing in query dsl way
curl -XPOST "http://localhost:9200/documents/doc/_search?routing=A&pretty" -d'
{
   "query": {
      "match_all": {}
   }
}'

#Custom routing with aliases
curl -XPOST 'http://localhost:9200/_aliases' -d '{
  "actions" : [
    {
      "add" : {
        "index" : "documents",
        "alias" : "documentsA",
        "routing" : "A"
      }
    }
  ]
}'

#Query documents using multiple routing values
curl -XGET 'localhost:9200/documents/_search?routing=A,B'

#Multiple routing values in combination of aliases
curl -XPOST 'http://localhost:9200/_aliases' -d '{
  "actions" : [
    {
      "add" : {
        "index" : "documents",
        "alias" : "documentsA",
        "search_routing" : "A,B",
        "index_routing" : "A"
      }
    }
  ]
}'

#Example of using query execution preference.
curl -XGET "http://localhost:9200/documents/_search?preference=_primary&pretty" -d'
{
   "query": {
      "match_all": {}
   }
}'


