class BootstrapMonthCalendar < SimpleCalendar::MonthCalendar
  def initialize_with_bootstrap(view_context, opts = {})
    opts.reverse_merge!(
      table: { class: 'table calendar' },
      header: { class: 'pagination' },
      previous_link: bootstrap_previous_link,
      next_link: bootstrap_next_link,
    )

    initialize_without_bootstrap(view_context, opts)
  end
  alias_method_chain :initialize, :bootstrap

  def default_title_with_bootstrap
    ->(start_date) { content_tag(:li, content_tag(:span, month_name(start_date)), class: 'disabled') }
  end
  alias_method_chain :default_title, :bootstrap

  def render_header_with_bootstrap
    capture do
      content_tag :ul, { class: 'pagination' }.merge(get_option(:header)) do
        concat get_option(:previous_link, param_name, date_range)
        concat get_option(:title, start_date)
        concat get_option(:next_link, param_name, date_range)
      end
    end
  end
  alias_method_chain :render_header, :bootstrap

  def bootstrap_previous_link
    ->(param, date_range) { content_tag :li, link_to(raw('&laquo;'), param => date_range.first - 1.day) }
  end

  def bootstrap_next_link
    ->(param, date_range) { content_tag :li, link_to(raw('&raquo;'), param => date_range.last + 1.day) }
  end
end

