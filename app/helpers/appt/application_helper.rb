module Appt
  module ApplicationHelper
    def title(title = nil)
      if title
        title = title.send(:title) if title.respond_to?(:title)
        content_for(:title){ title }
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

    def breadcrumb(name, options = nil, html_options = nil, &block)
      content_tag(:li) do
        if options
          concat link_to name, options, html_options, &block
        else
          concat name
        end
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

