#!/usr/bin/env ruby

module NycAdcJsonifier

	class Section

		attr_reader :heading_identifier, :chaptersection, :title_identifier, :title_text, :chapter_identifier, :chapter_text, :chaptersection, :catch_text

		attr_accessor :section_text

		def initialize(heading_identifier, title_identifier, title_text,
			chapter_identifier, chapter_text, chaptersection, catch_text)
			@heading_identifier = heading_identifier
			@title_identifier 	= title_identifier
			@title_text					= title_text
			@chapter_identifier = chapter_identifier
			@chapter_text				= chapter_text
			@chaptersection 		= chaptersection
			@catch_text					= catch_text
			@section_text				= section_text
		end
	end
end