module LogParser
  class Storage
    def initialize(page_views: [])
      @page_views = page_views
    end

    def total_page_views
      page_views_summary do |page_views_collection|
        page_views_collection.size
      end
    end

    def unique_page_views
      page_views_summary do |page_views_collection|
        page_views_collection.uniq(&:ip).size
      end
    end

    private

    attr_reader :page_views

    def page_views_by_path
      @page_views_by_path ||= page_views.group_by(&:path)
    end

    def page_views_summary
      page_views_by_path.each_with_object({}) do |grouped_page_views, acc|
        path, path_page_views = grouped_page_views
        acc[path] = yield(path_page_views)
      end.sort_by { |k, v| -v }.to_h
    end
  end
end
