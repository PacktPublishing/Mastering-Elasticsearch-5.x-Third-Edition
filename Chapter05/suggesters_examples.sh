#Using the _suggest REST endpoint on single field
curl -XPOST 'localhost:9200/wikinews/_suggest?pretty' -d'
{
  "first_suggestion" : {
    "text" : "chrimes in wordl",
    "term" : {
      "field" : "title"
    }
  }
}'

#Using the _suggest REST endpoint on two fields
curl -XPOST 'localhost:9200/wikinews/_suggest?pretty' -d '{
 "first_suggestion" : {
  "text" : "chrimes in wordl",
  "term" : {
   "field" : "title"
  }
 },
 "second_suggestion" : {
  "text" : "arest",
  "term" : {
   "field" : "text"
  }
 }
}'

#Including suggestion requests in query
curl -XGET 'localhost:9200/wikinews/_search?pretty' -d '{
 "query" : {
  "match_all" : {}
 },
 "suggest" : {
  "first_suggestion" : {
   "text" : "chrimes in wordl",
   "term" : {
    "field" : "_all"
   }
  }
 }
}'

#Multiple suggestion stypes on same text
curl -XGET 'localhost:9200/wikinews/_search?pretty' -d '{
 "query" : {
  "match_all" : {}
 },
 "suggest" : {
  "text" : "arest",
  "first_suggestion" : {
   "term" : {
    "field" : "text"
   }
  },
  "second_suggestion" : {
   "term" : {
    "field" : "title"
   }
  }
 }
}'

#Using The phrase suggester
curl -XGET "localhost:9200/wikinews/_search?pretty" -d'
{
   "query": {
      "match_all": {}
   },
   "suggest": {
      "text": "Unitd States",
      "our_suggestion": {
         "phrase": {
            "field": "text"
         }
      }
   }
}'

#USing phrase suggester with additional parameters
curl -XGET "http://localhost:9200/wikinews/_search?pretty" -d'
{
   "suggest": {
      "text": "chrimes in wordl",
      "our_suggestion": {
         "phrase": {
            "field": "text",
            "highlight": {
               "pre_tag": "<b>",
               "post_tag": "</b>"
            },
            "collate": {
               "prune": true,
               "query": {
                  "inline": {
                     "match": {
                        "title": "{{suggestion}}"
                     }
                  }
               }
            }
         }
      }
   }
}'

#Using smoothing models parameters with suggester
curl -XGET 'localhost:9200/wikinews/_suggest?pretty&size=0' -d '{
  "text" : "chrimes in world",
  "generators_example_suggestion" : {
   "phrase" : {
    "analyzer" : "standard",
    "field" : "text",
    "smoothing" : {
     "linear" : {
      "trigram_lambda" : 0.1,
      "bigram_lambda" : 0.6,
      "unigram_lambda" : 0.3
     }                      
    }
   }
  }
 }'

#Using candidate generators parameters with phrase suggester
curl -XGET 'localhost:9200/wikinews/_suggest?pretty&size=0' -d '{
  "text" : "chrimes in wordl",
  "generators_example_suggestion" : {
   "phrase" : {
    "analyzer" : "standard",
    "field" : "text",
    "direct_generator" : [ 
     {
      "field" : "text",
      "suggest_mode" : "always",
      "min_word_length" : 2
     }, 
     {
      "field" : "text",
      "suggest_mode" : "always",
      "min_word_length" : 3
     } 
    ]
   }
  }
}'

#Using the completion suggester
curl -XPUT "http://localhost:9200/authors" -d'
{
   "mappings": {
      "author": {
         "properties": {
            "name": {
               "type": "keyword"
            },
            "suggest": {
               "type": "completion"
            }
         }
      }
   }
}'

#Indexing data for testing completion suggester
curl -XPOST 'localhost:9200/authors/author/1' -d '{
 "name" : "Fyodor Dostoevsky",
 "suggest" : {
  "input" : [ "fyodor", "dostoevsky" ]
 }
}'


curl -XPOST 'localhost:9200/authors/author/2' -d '{
 "name" : "Joseph Conrad",
 "suggest" : {
  "input" : [ "joseph", "conrad" ]
 }
}'

#A simple completion suggester query example
curl -XGET 'localhost:9200/authors/_suggest?pretty' -d '{
 "authorsAutocomplete" : {
  "prefix" : "fyo",
  "completion" : {
   "field" : "suggest"
  }
 }
}'

#Indexing document with custom weights for completion type field
curl -XPOST 'localhost:9200/authors/author/1' -d '{
 "name" : "Fyodor Dostoevsky",
 "suggest" : {
  "input" : [ "fyodor", "dostoevsky" ],
  "weight" : 80
 }
}'

#Using fuzziness with completion suggester
curl -XGET "http://localhost:9200/authors/_suggest?pretty" -d'
{
   "authorsAutocomplete": {
      "text": "fio",
      "completion": {
         "field": "suggest",
         "fuzzy": {
            "fuzziness": 2
         }
      }
   }
}'

