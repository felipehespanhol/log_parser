require "spec_helper"
require "log_parser/storage"
require "log_parser/page_view"

RSpec.describe LogParser::Storage do
  let(:page_views) do
    [
      LogParser::PageView.new(path: "/home", ip: "192.168.0.1"),
      LogParser::PageView.new(path: "/home", ip: "192.168.0.1"),
      LogParser::PageView.new(path: "/home", ip: "192.168.0.2"),
      LogParser::PageView.new(path: "/contact_us", ip: "192.168.0.1"),
      LogParser::PageView.new(path: "/contact_us", ip: "192.168.0.2"),
      LogParser::PageView.new(path: "/contact_us", ip: "192.168.0.3"),
      LogParser::PageView.new(path: "/about", ip: "192.168.0.1"),
      LogParser::PageView.new(path: "/about", ip: "192.168.0.1")
    ]
  end

  describe "#total_page_views" do
    subject { described_class.new(page_views: page_views).total_page_views }

    it "returns a hash with path as keys and total page views count as values" do
      expect(subject).to eq({
        "/home" => 3,
        "/contact_us" => 3,
        "/about" => 2
      })
    end
  end

  describe "#unique_page_views" do
    subject { described_class.new(page_views: page_views).unique_page_views }

    it "returns a hash with path as keys and unique page views count as values" do
      expect(subject).to eq({
        "/contact_us" => 3,
        "/home" => 2,
        "/about" => 1
      })
    end
  end
end
