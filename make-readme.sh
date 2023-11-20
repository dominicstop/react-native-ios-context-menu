#!/bin/bash

rm -f ./README.md
cat ./docs/README-01-Pre.md ./docs/README-02-Docs.md ./docs/README-03-Examples.md ./docs/README-04-Post.md > ./README.md
sed -i 's/](..\/assets/\]\(.\/assets/' ./README.md