# Migrate PrestaShop 1.6 to PHP 7.3

This script helps migrate PrestaShop to PHP 7.3 (not supported in the official version).

Warning
---

This fixes common gotchas, but your shop may need adjustments, especially with some modules.
Please please please, run this first on a **versionned** code base and in a **development environment**. I'm not responsible if you break your shop!

Usage
---

```sh
git clone https://github.com/aeyoll/prestashop-1.6-php-migration.git
cd prestashop-1.6-php-migration
cp * your-prestashop-dir
cd your-prestashop-dir
composer install
./migrate.sh