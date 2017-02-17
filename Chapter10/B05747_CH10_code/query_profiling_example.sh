#Query profiling for detailed query execution report
#Example of using validate API to find how search requests are executed at low level so that the user can understand why certain requests are slow, and take steps to improve them. Executing th beqlow command will retunr a very detailed response which we can also found in the code bundle of this chapter under profile_api_response.json
curl -XGET "http://localhost:9200/elasticsearch_books/_search" -d'
{
  "profile": true,
  "query" : {
    "match" : { "title" : "mastering elasticsearch" }
  }
}'

