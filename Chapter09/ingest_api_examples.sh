#command for creating an ingest pipeline
curl -XPUT "localhost:9200/_ingest/pipeline/pipeline-id" -d'
{
   "description": "pipeline description",
   "processors": [
      {
         "set": {
            "field": "foo",
            "value": "bar"
         }
      }
   ]
}'

#command for getting a pipeline details from Elasticsearch
curl -XGET 'localhost:9200/_ingest/pipeline/pipeline-id?pretty'

#command for deleting a pipeline details from Elasticsearch
curl -XDELETE 'localhost:9200/_ingest/pipeline/pipeline-id'











