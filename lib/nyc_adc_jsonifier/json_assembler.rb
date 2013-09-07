#!/usr/bin/env ruby

require 'csv'
require 'nokogiri'
require 'open-uri'
require 'json'

require_relative 'section'
require_relative 'json_file'

class JsonAssembler

	attr_reader :section_parts

	attr_accessor :json_files

	def initialize
		@section_parts 	= []
		@json_files 		= []
	end

	def get_csv_data(csv_file)
		CSV.foreach(csv_file, headers: true) do |row|
			@section_parts << Section.new(row["heading_identifier"], row["title_identifier"],
				row["title_text"], row["chapter_identifier"], row["chapter_text"],
				row["chaptersection"], row["catch_text"])
		end
	end

	def get_site_content
		@section_parts.each do |section|
			url = "http://public.leginfo.state.ny.us/LAWSSEAF.cgi?QUERYTYPE=LAWS+&QUERYDATA=$$ADC#{section.heading_identifier}$$@TXADC01#{section.chaptersection}+&LIST=LAW"
			 	content = Nokogiri::HTML(open(url)).xpath('//pre').text
			 	clean_site_content(content)
			 	section.section_text = content
		end
	end

	def build_json
		@section_parts.each do |section|
			json = {
					"text" => "#{section.section_text}",
					"sections" => [

					],
					"title" => {
						"identifier"=>"#{section.title_identifier.to_i}",
						"text"=>"#{section.title_text}"
					},
					"chapter" => {
						"identifier" => "#{section.chapter_identifier.to_i}",
						"text" => "#{section.chapter_text}"	
					},
					"heading" => {
						"title" => "#{section.title_identifier}",
						"chaptersection" => "#{section.chaptersection.to_i}",
						"identifier" => "#{section.heading_identifier}",
						"catch_text" => "#{section.catch_text}"
					}
				}
			pretty_json = JSON.pretty_generate(json)
			filename = "#{section.heading_identifier}.json"
			@json_files << JsonFile.new(filename, pretty_json)
		end
	end

	def json_to_file
		@json_files.each do |json|
			File.open("#{json.filename}", "w") do |file|
				file.print json.pretty_json
			end
		end
	end

	private

	def clean_site_content(content)
		content.gsub!(/[\r\n]/, ' ')
		content.sub!(/^.*?[\.!\?](?:\s+|$)/, '')
		content.gsub!(/\s+/, ' ')
	end
end