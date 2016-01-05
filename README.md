# xls2csv

xls2csv is a simple Ruby script which converts a given xls File to a set of csv files.

## Usage

```bash
Usage: ruby xls2csv.rb -f <inputfile> [options]
Reads an XLS file and converts every worksheet to a csv file

    -f filename                      Path to the XLS file
    -c col_sep                       Column separator. Defaults to ','
    -e encoding                      Output file encoding. Defaults to UTF-8
    -q quote_char                    Quote char. Defaults to an empty string
    -R, --remove-empty-rows          Removes empty rows
    -N, --remove-first-n-rows count  Removes the first N rows. Empty rows are included here
    -W sheet_index1,sheet_index2,    Only transforms the worksheets with the specific indexes starting at 0
        --only-specific-worksheets
    -h, --help                       Show this message
``

### License
[LICENSE](LICENSE)
