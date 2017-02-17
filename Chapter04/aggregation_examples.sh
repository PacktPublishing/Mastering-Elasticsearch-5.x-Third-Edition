#avg_buket aggregation example
curl -XGET "http://localhost:9200/books/transactions/_search?pretty" -d'
{
   "aggs":{
      "sales_per_month":{
         "date_histogram":{
            "field":"sold",
            "interval":"month",
            "format":"yyyy-MM-dd"
         },
         "aggs":{
            "monthly_sum":{
               "sum":{
                  "field":"price"
               }
            }
         }
      },
      "avg_monthly_sales":{
         "avg_bucket":{
            "buckets_path":"sales_per_month>monthly_sum"
         }
      }
   },"size": 0
}'

#derivative aggregation example
curl -XGET "http://localhost:9200/books/transactions/_search?pretty" -d'
{
   "aggs": {
      "sales_per_month": {
         "date_histogram": {
            "field": "sold",
            "interval": "month",
            "format": "yyyy-MM-dd"
         },
         "aggs": {
            "monthly_sum": {
               "sum": {
                  "field": "price"
               }
            },
            "sales_deriv": {
               "derivative": {
                  "buckets_path": "monthly_sum"
               }
            }
         }
      }
   },"size": 0
}'

#matrix stats aggregation example
curl -XGET "http://localhost:9200/persons/_search?pretty" -d'
{
  "aggs": {
    "matrixstats": {
      "matrix_stats": {
        "fields": [
          "height",
          "self_esteem"
        ]
      }
    }
  },"size": 0
}'
