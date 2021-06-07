#!/bin/sh

# Utils
###############################################################################

display_help_message() {
    print_error "Usage: $0"
}

print_error() {
    echo -e "$(bold_red "$1")" 1>&2
}

bold_red() {
    echo -e "\e[31;1m$1\e[0;20m"
}

# Patches
###############################################################################

# Cast all count parameters to array
patch_cast_count_parameters() {
    find . -type f -iname *.php -exec sed -i 's/(count(\$/(count((array) \$/g' {} \;
    find . -type f -iname *.php -exec sed -i 's/ count(\$/ count((array) \$/g' {} \;
    find . -type f -iname *.php -exec sed -i 's/(!count(\$/(!count((array) \$/g' {} \;
    find . -type f -iname *.php -exec sed -i 's/ !count(\$/ !count((array) \$/g' {} \;
}

# Patch smarty
patch_smarty() {
    patch -p1 < 0001-smarty.patch
}

# Patch php's deprecated "create_function"
patch_deprecated_create_function() {
    patch -p1 < 0002-deprecated-create_function.patch
}

# Launch rector
patch_rector() {
    composer install
    vendor/bin/rector process
}

# Main Process
###############################################################################

run_migration() {
    patch_cast_count_parameters()
    patch_smarty()
    patch_deprecated_create_function()
}

main() {
    local env=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help)
                display_help_message
                exit 0
            ;;
            -*)
                print_error "Unknown option \"$1\""
                exit 1
            ;;
            *)
               env="$1"
            ;;
        esac

        shift
    done

    local exit_code=0
    run_migration || exit_code=$?
    return ${exit_code}
}

main "$@"
