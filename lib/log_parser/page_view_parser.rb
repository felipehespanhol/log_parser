require_relative "page_view"

module LogParser
  class PageViewParser
    class ParseError < StandardError; end

    def initialize(page_views_string:)
      @page_views_string = page_views_string
    end

    def call
      page_views_string.split("\n").each_with_object([]) do |page_view_string, acc|
        path, ip = parse_line(page_view_string)
        # If path and IP are nil then this is an empty line, so skip it
        acc << PageView.new(path: path, ip: ip) unless path.nil? && ip.nil?
      end
    end

    private

    attr_accessor :page_views_string

    def parse_line(line_string)
      info = line_string.split(" ")
      raise ParseError if info.size > 2
      info
    end
  end
end
