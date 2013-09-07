#!/usr/bin/env ruby

require_relative 'json_assembler'

assembler = JsonAssembler.new
ARGV.each do |csv_file|
	assembler.get_csv_data(csv_file)
end

assembler.get_site_content
assembler.build_json
assembler.json_to_file