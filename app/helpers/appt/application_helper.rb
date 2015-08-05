module Appt
  module ApplicationHelper
    def title(title = nil)
      if title
        content_for(:title) { title }
      else
        content_for?(:title) ? content_for(:title) : nil
      end
    end

    def breadcrumbs(&block)
      content_for(:breadcrumbs) do
        capture do
          content_tag(:ol, class: 'breadcrumb') do
            concat breadcrumb 'Home', root_path
            concat capture(&block) if block_given?
            concat content_tag(:li, title, class: 'active')
          end
        end
      end
    end

    def breadcrumb(name, options, html_options = nil, &block)
      content_tag(:li) do
        concat link_to name, options, html_options, &block
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

