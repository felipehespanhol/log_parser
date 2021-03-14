require "spec_helper"
require "log_parser/cli"

RSpec.describe LogParser::Cli do
  let(:stdout_mock) { StringIO.new }

  describe "#initialize" do
    context "when file path does not exist" do
      subject { described_class.new(log_file: "./fixtures/nonexistingfile.log", output: stdout_mock) }

      it "raises FileDoesNotExistError" do
        expect { subject }.to raise_error(LogParser::Cli::FileDoesNotExist)
      end
    end
  end

  describe "#call" do
    subject { described_class.new(log_file: "./fixtures/webserver.log", output: stdout_mock) }

    it "prints the summarized page views and unique page views" do
      subject.call
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
  end
end
