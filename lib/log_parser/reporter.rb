module LogParser
  class Reporter
    def initialize(storage:)
      @storage = storage
    end

    def call
      [total_page_views_string, unique_page_views_string].join("\n")
    end

    private

    def total_page_views_string
      page_view_list(
        title: "Total page views",
        description: "visit",
        storage_method: :total_page_views
      )
    end

    def unique_page_views_string
      page_view_list(
        title: "Unique page views",
        description: "unique view",
        storage_method: :unique_page_views
      )
    end

    def page_view_list(title:, description:, storage_method:)
      page_views_list = storage.send(storage_method).inject("") do |acc, page_view|
        path, count = page_view
        acc + "\n#{path} #{count} #{description}#{"s" if count > 1}"
      end
      <<~OUTPUT
        # #{title}
        #{page_views_list}
      OUTPUT
    end

    private

    attr_reader :storage
  end
end
