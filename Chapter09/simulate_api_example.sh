#An example of using simulate request in which we ar simply adding a new field category and its value as search engine using set processor
curl -XPOST "http://localhost:9200/_ingest/pipeline/_simulate?pretty" -d'
{
  "pipeline" :
  {
    "description": "adding a new field and value to the each document",
    "processors": [
      {
        "set" : {
          "field" : "category",
          "value" : "search engine"
        }
      }
    ]
  },
  "docs": [
    {
      "_index": "index",
      "_type": "type",
      "_id": "id",
      "_source": {
        "name": "lucene"
      }
    },
    {
      "_index": "index",
      "_type": "type",
      "_id": "id",
      "_source": {
        "name": "elasticsearch"
      }
    }
  ]
}'

#Example of using verbose parameter in a simulate request to see how each processor affects the document as it passes through the pipeline. In following example, we are using a simulate request which contains two processors, each adding a new field to each of the ingest documents.
curl -XPOST "http://localhost:9200/_ingest/pipeline/_simulate?pretty&verbose" -d'
{
  "pipeline" :
  {
    "description": "adding a new field and value to the each document",
    "processors": [
      {
        "set" : {
          "field" : "category",
          "value" : "search engine"
        }
      },
      {
        "set" : {
          "field" : "field3",
          "value" : "value3"
        }
      }
    ]
  },
  "docs": [
    {
      "_index": "index",
      "_type": "type",
      "_id": "id",
      "_source": {
        "name": "lucene"
      }
    },
    {
      "_index": "index",
      "_type": "type",
      "_id": "id",
      "_source": {
        "name": "elasticsearch"
      }
    }
  ]
}'


