#Creating index with settings and mappings
curl -XPUT "http://localhost:9200/location-suggestion" -d'
{
   "settings": {
      "index": {
         "analysis": {
            "filter": {
               "nGram_filter": {
                  "token_chars": [
                     "letter",
                     "digit",
                     "punctuation",
                     "symbol",
                     "whitespace"
                  ],
                  "min_gram": "2",
                  "type": "nGram",
                  "max_gram": "20"
               }
            },
            "analyzer": {
               "nGram_analyzer": {
                  "filter": [
                     "lowercase",
                     "asciifolding",
                     "nGram_filter"
                  ],
                  "type": "custom",
                  "tokenizer": "whitespace"
               },
               "whitespace_analyzer": {
                  "filter": [
                     "lowercase",
                     "asciifolding"
                  ],
                  "type": "custom",
                  "tokenizer": "whitespace"
               }
            }
         }
      }
   },
   "mappings": {
      "locations": {
         "properties": {
            "name": {
               "type": "text",
               "analyzer": "nGram_analyzer",
               "search_analyzer": "whitespace_analyzer"
            },
            "country": {
               "type": "keyword"
            }
         }
      }
   }
}'


#Indexing Documents
curl -XPUT "http://localhost:9200/location-suggestion/location/1" -d'
{"name":"Bradford","country":"england"}'
curl -XPUT "http://localhost:9200/location-suggestion/location/2" -d'
{"name":"Bridport","country":"england"}'
curl -XPUT "http://localhost:9200/location-suggestion/location/3" -d'
{"name":"San Diego Country Estates","country":"usa"}'
curl -XPUT "http://localhost:9200/location-suggestion/location/4" -d'
{"name":"Ike’s Point, NJ","country":"usa"}'

#Querying Documents for Auto-completion
curl -XGET "http://localhost:9200/location-suggestion/location/_search" -d'
{
   "query": {
      "match": {
         "name": "ke’s"
      }
   }
}'

