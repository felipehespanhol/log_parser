require_relative "page_view_parser"
require_relative "storage"
require_relative "reporter"

module LogParser
  class Cli
    class FileDoesNotExist < StandardError; end

    attr_reader :log_file, :output

    def initialize(log_file:, output: $stdout)
      @log_file = log_file
      @output = output
    end

    def call
      file_contents = read_log_file
      page_views = PageViewParser.new(page_views_string: file_contents).call
      storage = Storage.new(page_views: page_views)
      report = Reporter.new(storage: storage).call
      output.puts report
    rescue FileDoesNotExist
      output.puts "ERROR: File #{log_file} could not be found."
    rescue PageViewParser::ParseError
      output.puts "ERROR: Malformed file."
    end

    private

    def read_log_file
      File.read(log_file)
    rescue Errno::ENOENT
      raise FileDoesNotExist
    end
  end
end
