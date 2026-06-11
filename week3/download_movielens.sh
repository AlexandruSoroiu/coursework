#!/bin/bash

#
# downloads movielens rating data
#
# see http://grouplens.org/datasets/movielens/ for more info
#

url=https://files.grouplens.org/datasets/movielens/ml-10m.zip

# download ratings zip file
<<<<<<< HEAD
[ -f ml-10m.zip ] || curl -o ml-10m.zip $url
=======
[ -f movielens_10M.zip ] || curl -L -o movielens_10M.zip $url
>>>>>>> f2f1de5d75b3d147a44bc7c4c163222c294c75e1

# uncompress zip file
if [ ! -f ratings.dat ]
    then
    unzip ml-10m.zip && mv ml-10M100K/* .
fi

# reformat to comma-separated file
[ -f ratings.csv ] || cat ratings.dat | sed 's/::/,/g' > ratings.csv

[ -f movies.tsv ] || cat movies.dat | sed 's/::/	/g' > movies.tsv