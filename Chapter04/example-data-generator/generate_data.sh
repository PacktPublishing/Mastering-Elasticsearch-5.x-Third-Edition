#!/bin/bash

NATURAL="natural"
NESTED="nested"
PARENT_CHILD_M="pch_m"
PARENT_CHILD_S="pch"

REC=10000


# natural

for i in $(seq $REC)
do
cat <<-END
				{"index": {"_index": "rel_${NATURAL}", "_type": "book", "_id": "${i}"}}
				{"title" : "Doc no ${i}", "quantity" : 10${i}, "edition" : { "isbn" : "no${i}", "circulation" : 50${i} }}
END
done


# nested

for i in $(seq $REC)
do
cat <<-END
				{"index": {"_index": "rel_${NESTED}", "_type": "book", "_id": "${i}"}}
  			{"title" : "Doc no ${i}", "quantity" : 10${i}, "edition" : { "isbn" : "no${i}", "circulation" : 50${i} }}
END
done

# parent - child

for i in $(seq $REC)
do
cat <<-END
				{"index": {"_index": "rel_${PARENT_CHILD_S}", "_type": "edition", "_id": "${i}", "_parent": "1"}}
				{"isbn" : "no${i}", "circulation" : 50${i}}
END
done
