module LogParser
  class PageView
    attr_accessor :path, :ip

    def initialize(path:, ip:)
      @path = path
      @ip = ip
    end
  end
end
