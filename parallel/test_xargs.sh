#! /bin/bash

start=$(date "+%s")
cat text.txt | xargs -L 1 -P 8 -I {} ./test.sh {}
end=$(date "+%s")

time=$((end - start))
echo "time userd: $time seconds"
