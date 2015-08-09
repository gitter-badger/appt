class BootstrapMonthCalendar < SimpleCalendar::MonthCalendar
  def initialize_with_bootstrap(view_context, opts = {})
    opts.reverse_merge!(
      table: { class: 'table calendar' },
      header: { class: 'pager' },
      previous_link: bootstrap_previous_link,
      next_link: bootstrap_next_link,
    )

    initialize_without_bootstrap(view_context, opts)
  end
  alias_method_chain :initialize, :bootstrap

  def default_title_with_bootstrap
    ->(start_date){ content_tag(:li, content_tag(:span, month_name(start_date)), class: 'disabled') }
  end
  alias_method_chain :default_title, :bootstrap

  def render_header_with_bootstrap
    capture do
      content_tag :nav do
        content_tag :ul, get_option(:header) do
          concat get_option(:previous_link, param_name, date_range)
          concat get_option(:title, start_date)
          concat content_tag :li, link_to('Today', param_name => nil) unless current_month?
          concat get_option(:next_link, param_name, date_range)
        end
      end
    end +
      link_to('Today', { params => nil }, class: 'btn btn-link')
  end
  alias_method_chain :render_header, :bootstrap

  def bootstrap_previous_link
    ->(p, r){ content_tag :li, link_to(raw('&laquo;'), p => r.first - 1.day), class: 'previous' }
  end

  def bootstrap_next_link
    ->(p, r){ content_tag :li, link_to(raw('&raquo;'), p => r.last + 1.day), class: 'next' }
  end

  def current_month?
    timezone.now.to_date.beginning_of_month == start_date.beginning_of_month
  end
end

