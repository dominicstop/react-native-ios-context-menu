#!/bin/bash

rm -f ./README.md
cat ./docs/README-01-Pre.md ./docs/README-02-Docs.md ./docs/README-03-Examples.md ./docs/README-04-Post.md > ./README.md

# Replace "](../assets/" -> "](./assets/"
sed -i '' 's/](..\/assets/\]\(.\/assets/' ./README.md

# Replace "](../example/src" -> "](./example/src"
sed -i '' 's/](..\/example\/src\//]\(.\/example\/src/g' ./README.md