require "spec_helper"
require "log_parser/cli"

RSpec.describe LogParser::Cli do
  let(:stdout_mock) { StringIO.new }

  describe "#call" do
    subject { described_class.new(log_file: "./fixtures/webserver.log", output: stdout_mock).call }

    it "prints the summarized page views and unique page views" do
      subject
      expect(stdout_mock.string).to eq <<~OUTPUT
        # Total page views

        /home 5 visits
        /contact 3 visits
        /help_page/1 2 visits
        /about 1 visit

        # Unique page views

        /home 3 unique views
        /help_page/1 2 unique views
        /contact 2 unique views
        /about 1 unique view
      OUTPUT
    end

    context "when file path does not exist" do
      subject { described_class.new(log_file: "./fixtures/nonexistingfile.log", output: stdout_mock).call }

      it "prints friendly error message to output" do
        expect { subject }.to change { stdout_mock.string }
          .from("").to("ERROR: File ./fixtures/nonexistingfile.log could not be found.\n")
      end
    end

    context "when there is an error while parsing" do
      before do
        allow_any_instance_of(LogParser::PageViewParser)
          .to receive(:call).and_raise(LogParser::PageViewParser::ParseError)
      end

      it "outputs friendly error message to stdout" do
        subject
        expect(stdout_mock.string).to eq "ERROR: Malformed file.\n"
      end
    end
  end
end
