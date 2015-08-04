module Appt
  module ApplicationHelper
    def title(title = nil)
      if title
        content_for(:title) { title }
      else
        content_for?(:title) ? content_for(:title) : nil
      end
    end

    def time_ago_tag(value)
      if value.nil?
        nil
      else
        # TODO: i18n?
        time_tag(value, "#{time_ago_in_words(value)} ago", title: value.strftime('%m/%d/%Y %I:%M%p'))
      end
    end
  end
end

