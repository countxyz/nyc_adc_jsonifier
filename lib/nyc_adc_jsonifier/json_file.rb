#!/usr/bin/env ruby

module NycAdcJsonifier

  class JsonFile

    attr_reader :filename, :pretty_json

    def initialize(filename, pretty_json)
      @filename     = filename
      @pretty_json  = pretty_json
    end
  end
end