require "spec_helper"
require "log_parser/reporter"

RSpec.describe LogParser::Reporter do
  let(:storage) do
    instance_double(
      "LogParser::Storage",
      total_page_views: {
        "/home" => 2,
        "/contact_us" => 1,
        "/about" => 3
      },
      unique_page_views: {
        "/home" => 1,
        "/contact_us" => 1,
        "/about" => 2
      }
    )
  end

  describe "#call" do
    subject { described_class.new(storage: storage).call }

    it "returns a string containing the total and the unique page views" do
      expect(subject).to eq <<~OUTPUT
        # Total page views

        /home 2 visits
        /contact_us 1 visit
        /about 3 visits

        # Unique page views

        /home 1 unique view
        /contact_us 1 unique view
        /about 2 unique views
      OUTPUT
    end
  end
end
