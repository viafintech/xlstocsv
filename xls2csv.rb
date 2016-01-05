require 'csv'
require 'optparse'
require 'spreadsheet'

options = {
  col_sep:    ",",
  encoding:   "UTF-8",
  quote_char: "",
  remove_empty_rows:   false,
}
optionparser = OptionParser.new do |opts|
  opts.banner = "Usage: ruby #{File.basename(__FILE__)} -f <inputfile> [options]\n" +
                "Reads an XLS file and converts every worksheet to a csv file\n\n"

  opts.on('-f filename', "Path to the XLS file") do |file|
    options[:filename] = file
  end

  opts.on('-c col_sep', "Column separator. Defaults to ','") do |col_sep|
    options[:col_sep] = col_sep
  end

  opts.on('-e encoding', "Output file encoding. Defaults to UTF-8") do |encoding|
    options[:encoding] = encoding
  end

  opts.on('-q quote_char', "Quote char. Defaults to an empty string") do |quote_char|
    options[:quote_char] = quote_char
  end

  opts.on('-R', '--remove-empty-rows', 'Removes empty rows') do |remove|
    options[:remove_empty_rows] = remove
  end

  opts.on('-N count', '--remove-first-n-rows', 'Removes the first N rows. Empty rows are included here') do |count|
    options[:remove_first_n_rows] = count.to_i
  end

  opts.on('-W sheet_index1,sheet_index2', '--only-specific-worksheets',
    'Only transforms the worksheets with the specific indexes starting at 0') do |worksheets|
    options[:only_specific_worksheets] = worksheets.split(',').map{ |val| val.to_i }
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit(false)
  end
end
optionparser.parse!

if options[:filename].nil?
  puts optionparser
  exit
end

csv_params = {
  col_sep:    options[:col_sep],
  encoding:   options[:encoding],
  quote_char: options[:quote_char]
}

csv_params.delete(:quote_char) if csv_params[:quote_char].to_s.length < 1

report = Spreadsheet.open(options[:filename])

report.worksheets.each_with_index do |sheet, sheet_index|
  next if !options[:only_specific_worksheets].nil? && !options[:only_specific_worksheets].include?(sheet_index)

  filename = File.basename(options[:filename], ".*")
  filepath = File.join( File.dirname(options[:filename]), "#{filename}_#{sheet_index}.csv" )

  csv_data = CSV.generate(csv_params) do |csv|
    sheet.rows.each_with_index do |row, row_index|
      next if !options[:remove_first_n_rows].nil? && row_index < options[:remove_first_n_rows]
      next if row.to_a.empty? && options[:remove_empty_rows]


      csv << row.to_a
    end
  end

  puts "Writing #{filepath}"
  File.open(filepath, "w:#{options[:encoding]}") { |f| f.write(csv_data) }
end
