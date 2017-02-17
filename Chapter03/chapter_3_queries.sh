#best fields search query
curl -XGET 'localhost:9200/library/_search?pretty' -d '{
 "query" : {
  "multi_match" : {
   "query" : "complete conan doyle",
   "fields" : [ "title", "author", "characters" ],
   "type" : "best_fields",
   "tie_breaker" : 0.8
  }
 }
}'

#best fields search query with AND operator
curl -XGET 'localhost:9200/library/_search?pretty' -d '{
 "query" : {
  "multi_match" : {
   "query" : "complete conan doyle",
   "fields" : [ "title", "author", "characters" ],
   "type" : "best_fields",
   "operator" : "and"
  }
 }
}'

#cross fields search query
curl -XGET 'localhost:9200/library/_search?pretty' -d '{
 "query" : {
  "multi_match" : {
   "query" : "complete conan doyle",
   "fields" : [ "title", "author", "characters" ],
   "type" : "cross_fields",
   "operator" : "and"
  }
 }
}'

#most fields search query
curl -XGET 'localhost:9200/library/_search?pretty' -d '{
 "query" : {
  "multi_match" : {
   "query" : "Die Leiden",
   "fields" : [ "title", "otitle" ],
   "type" : "most_fields"
  }
 }
}'

#phrase search query
curl -XGET 'localhost:9200/library/_search?pretty' -d '{
 "query" : {
  "multi_match" : {
   "query" : "sherlock holmes",
   "fields" : [ "title", "author" ],
   "type" : "phrase"
  }
 }
}'

#phrase prefix search query
curl -XGET 'localhost:9200/library/_search?pretty' -d '{
 "query" : {
  "multi_match" : {
   "query" : "sherlock hol",
   "fields" : [ "title", "author" ],
   "type" : "phrase_prefix"
  }
 }
}'

#weight function score query
curl -XGET "http://localhost:9200/library/_search" -d'
{
  "query": {
    "function_score": {
      "query": {
        "match": {
          "tags": "novel"
        }
      },
      "functions": [
        {
          "filter": {
            "term": {
              "tags": "classics"
            }
          },
          "weight": 2
        }
      ],
      "boost_mode": "replace"
    }
  }
}'

#field value factor function score query
curl -XGET "http://localhost:9200/library/_search" -d'
{
  "query": {
    "function_score": {
      "query": {
        "term": {
          "tags": {
            "value": "novel"
          }
        }
      },
      "functions": [
        {
          "field_value_factor": {
            "field": "year"
          }
        }
      ],
      "boost_mode": "multiply"
    }
  }
}'

#exp decay function score query
curl -XGET "http://localhost:9200/library/_search" -d'
{
  "query": {
    "function_score": {
      "query": {
        "match_all": {}
      },
      "functions": [
        {
          "exp": {
            "year": {
              "origin": "2016",
              "scale": "100"
            }
          }
        }
      ],"boost_mode": "multiply"
    }
  }
}'

#query rescoring based on the value of a field
curl -XGET "http://localhost:9200/library/_search" -d'
{
  "query": {
    "match_all": {}
  },
  "rescore": {
    "query": {
      "rescore_query": {
        "function_score": {
          "query": {
            "match_all": {}
          },
          "script_score": {
            "script": {
              "inline": doc[\"year\"].value,
              "lang": "painless"
            }
          }
        }
      }
    }
  },"_source": ["title", "available"]
}'

#example of using rescore query parameters
curl -XPOST "http://localhost:9200/library/_search" -d'
{
   "query" : {
      "match" : {
         "title" : {
            "operator" : "or",
            "query" : "The Complete",
            "type" : "boolean"
         }
      }
   },
   "rescore" : {
      "window_size" : 50,
      "query" : {
        "score_mode":"max",
         "rescore_query" : {
            "match" : {
               "title" : {
                  "query" : "The Sorrows",
                  "type" : "boolean",
                   "operator" : "and"
               }
            }
         },
         "query_weight" : 0.7,
         "rescore_query_weight" : 1.2
      }
   },"_source": ["title", "available"]
}'

#painless scripting example for calculating score to the total value calculated based on the tags matched inside each document using for loop and conditional statements
curl -XPOST "http://localhost:9200/library/_search" -d'
{
  "query": {
    "function_score": {
      "query": {
        "match_all": {}
      },
      "min_score": 1,
      "script_score": {
        "script": {
          "inline": "def total = 0; for (int i = 0; i < doc[\"tags\"].length; i++)  { if (doc[\"tags\"][i] == \"novel\"){ total += 1;} else if (doc[\"tags\"][i] == \"classics\") {total+=10;} else {total+=20}} return total;",
          "lang": "painless"
        }
      }
    }
  }
}'


#painless scripting example for custom scroring based on book publication year
curl -XGET "http://localhost:9200/library/_search?pretty" -d'
{
  "_source": [
    "_id",
    "_score",
    "title",
    "year"
  ],
  "query": {
    "function_score": {
      "query": {
        "match_all": {}
      },
      "script_score": {
        "script": {
          "inline": "def year = doc[\"year\"].value; if (year < 1800) {return 1.0 } else if (year < 1900) { return 2.0 } else { return year - 1000 }",
          "lang": "painless"
        }
      }
    }
  }
}'

#painless scripting example of sorting
curl -XGET "http://localhost:9200/library/_search" -d'
{
  "query": {
    "match_all": {}
  },
  "sort": {
    "_script": {
      "type": "string",
      "order": "desc",
      "script": {
        "lang": "painless",
        "inline": "doc[\"tags\"].value"
      }
    }
  },"_source": "tags"
}'

#painless scripting example for sorting based on combined value of multiple fields
curl -XGET "http://localhost:9200/library/_search" -d'
{
  "query": {
    "match_all": {}
  },
  "sort": {
    "_script": {
      "type": "string",
      "order": "asc",
      "script": {
        "lang": "painless",
        "inline": "doc[\"first.keyword\"].value + \" \" + doc[\"last.keyword\"].value"
      }
    }
  }
}'

#Lucene expressions example
curl -XGET "http://localhost:9200/library/_search?pretty" -d'
{
  "_source": [
    "_id",
    "_score",
    "title"
  ],
  "query": {
    "function_score": {
      "query": {
        "match_all": {}
      },
      "script_score": {
        "script": {
          "inline": "_score + doc[\"year\"].value * percentage",
          "lang": "expression",
          "params": {
            "percentage": 0.1
          }
        }
      }
    }
  }
}'
