Gem::Specification.new do |s|
  s.name        = 'xlstocsv'
  s.version     = '0.0.1'
  s.date        = '2016-01-06'
  s.summary     = 'Convert XLS files to CSV files'
  s.authors     = ['Cash Payment Solutions GmbH']
  s.email       = 'tobias.schoknecht@barzahlen.de'
  s.homepage    = 'https://github.com/Barzahlen/xlstocsv'
  s.license     = 'MIT'
  s.executables << 'xlstocsv'
  s.files       = ['LICENSE']

  s.add_runtime_dependency 'spreadsheet', '~> 1.1.1'

  s.add_development_dependency 'rake', '~> 10.4.1'
end
