require "spec_helper"
require "log_parser/page_view"

RSpec.describe LogParser::PageView do
  let(:path) { "/help_page/1" }
  let(:ip) { "192.168.0.1" }

  subject { described_class.new(path: path, ip: ip) }

  it "returns a page view with path" do
    expect(subject.path).to eq path
  end

  it "returns a page view with p" do
    expect(subject.ip).to eq ip
  end
end
