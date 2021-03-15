require "spec_helper"
require "log_parser/page_view_parser"
require "log_parser/page_view"

RSpec.describe LogParser::PageViewParser do
  describe "#call" do
    context "with valid string" do
      let(:page_views_string) do
        '
          /home 192.168.0.1
          /contact_us 192.168.0.2
        '
      end

      subject { described_class.new(page_views_string: page_views_string).call }

      it "returns page views with paths and ips" do
        path_and_ips = subject.map { |page_view| {path: page_view.path, ip: page_view.ip} }
        expect(path_and_ips).to eq [
          {path: "/home", ip: "192.168.0.1"},
          {path: "/contact_us", ip: "192.168.0.2"}
        ]
      end
    end

    context "with invalid string" do
      let(:invalid_string) do
        '
          /address with too many spaces 192.168.0.1
        '
      end

      subject { described_class.new(page_views_string: invalid_string).call }

      it "raises ParseError" do
        expect { subject }.to raise_error(LogParser::PageViewParser::ParseError)
      end
    end
  end
end
