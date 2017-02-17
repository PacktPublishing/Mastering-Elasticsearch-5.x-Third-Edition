#Creating index for synonym search
curl -XPUT "http://localhost:9200/synonyms-index" -d'
{
   "settings": {
      "analysis": {
         "filter": {
            "my_synonym_filter": {
               "type": "synonym",
               "synonyms": [
                  "shares","equity","stock"
               ]
            }
         },
         "analyzer": {
            "my_synonyms": {
               "tokenizer": "standard",
               "filter": [
                  "lowercase",
                  "my_synonym_filter"
               ]
            }
         }
      }
   }
}'
