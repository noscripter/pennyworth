$url = "http://jsbin.com/"
$timeout = 5 # in seconds

require File.join(File.dirname(__FILE__), 'importer.rb')
require File.join(File.dirname(__FILE__), 'importer_http.rb')
Sass.load_paths << Sass::Importers::JSBin.new()
Sass.load_paths << Sass::Importers::HTTP.new($url, $timeout)
