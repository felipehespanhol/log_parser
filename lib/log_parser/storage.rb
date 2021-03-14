module LogParser
  class Storage
    attr_reader :page_views

    def initialize(page_views: [])
      @page_views = page_views
    end

    def total_page_views
      page_views_by_path.each_with_object({}) do |page_views, acc|
        path = page_views[0]
        count = page_views[1].size
        acc[path] = count
      end.sort_by { |k, v| -v }
    end

    def unique_page_views
      page_views_by_path.each_with_object({}) do |page_views, acc|
        path = page_views[0]
        count = page_views[1].uniq(&:ip).size
        acc[path] = count
      end.sort_by { |k, v| -v }
    end

    private

    def page_views_by_path
      @page_views_by_path ||= page_views.group_by(&:path)
    end
  end
end