#Download wiki news dump and index
wget https://github.com/bharvidixit/mastering-elasticsearch-5.0/raw/master/chapter-5/enwikinews-20160926-cirrussearch-content.json.gz
export dump=enwikinews-20160926-cirrussearch-content.json.gz
export index=wikinews
mkdir chunks
cd chunks
zcat ../$dump | split -a 10 -l 500 - $index

export es=localhost:9200

for file in *; do
  echo -n "${file}:  "
  took=$(curl -s -XPOST $es/$index/_bulk?pretty --data-binary @$file |
    grep took | cut -d':' -f 2 | cut -d',' -f 1)
  printf '%7s\n' $took
  [ "x$took" = "x" ] || rm $file
done
