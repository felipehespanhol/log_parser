require_relative "page_view_parser"
require_relative "storage"
require_relative "reporter"

module LogParser
  class Cli
    class FileDoesNotExist < StandardError; end

    def initialize(log_file:, output: $stdout)
      @file_contents = read_log_file(log_file)
      @output = output
    end

    def call
      page_views = PageViewParser.new(page_views_string: file_contents).call
      storage = Storage.new(page_views: page_views)
      report = Reporter.new(storage: storage).call
      output.puts report
    end

    private

    attr_reader :file_contents, :output

    def read_log_file(log_file)
      File.read(log_file)
    rescue Errno::ENOENT
      raise FileDoesNotExist
    end
  end
end
