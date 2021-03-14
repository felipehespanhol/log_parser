require_relative "page_view"

module LogParser
  class PageViewParser
    attr_accessor :page_views_string

    def initialize(page_views_string:)
      @page_views_string = page_views_string
    end

    def call
      page_views_string.split("\n").map do |page_view_string|
        path, ip = page_view_string.split(" ")
        PageView.new(path: path, ip: ip)
      end
    end
  end
end
