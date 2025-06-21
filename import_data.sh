#!/bin/bash

# 导入数据的函数
import_csv() {
    local file=$1
    local table=$2
    echo "Importing $file to $table..."
    docker exec -i postgres psql -U postgres -d wordsfunny -c "\COPY \"$table\" FROM STDIN WITH CSV HEADER" < "wordsfunny_data/$file"
}

echo "Starting data import..."

# 按照依赖顺序导入数据
import_csv "Book.csv" "Book"
import_csv "Word.csv" "Word"
import_csv "Cognate.csv" "Cognate"
import_csv "Phrase.csv" "Phrase"
import_csv "Sentence.csv" "Sentence"
import_csv "Synonym.csv" "Synonym"
import_csv "Translation.csv" "Translation"
import_csv "User.csv" "User"
import_csv "UsersToBooks.csv" "UsersToBooks"
import_csv "UsersToWords.csv" "UsersToWords"
import_csv "Verify.csv" "Verify"

echo "Data import completed!" 