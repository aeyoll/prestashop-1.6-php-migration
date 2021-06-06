#!/bin/sh

# Cast all count parameters to array
find . -type f -iname *.php -exec gsed -i 's/(count(\$/(count((array) \$/g' {} \;
find . -type f -iname *.php -exec gsed -i 's/ count(\$/ count((array) \$/g' {} \;
find . -type f -iname *.php -exec gsed -i 's/(!count(\$/(!count((array) \$/g' {} \;
find . -type f -iname *.php -exec gsed -i 's/ !count(\$/ !count((array) \$/g' {} \;

# Smarty fix
patch -p1 < 0001-smarty.patch

# "create_function" fix
patch -p1 < 0002-deprecated-create_function.patch

# rector
composer install
vendor/bin/rector process