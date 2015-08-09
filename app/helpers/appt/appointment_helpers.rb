module Appt
  module AppointmentHelpers
    def full_name_field(builder, firstname_att, lastname_att, options = {})
      capture do
        options[:class] ||= ''
        options[:class] << " #{builder.send(:error_class)}" if builder_has_error?(builder, firstname_att, lastname_att)
        options[:label] = { text: builder.object.class.human_attribute_name(:full_name), id: firstname_att }

        builder.form_group :full_name, options do
          content_tag :div, class: 'row' do
            content_tag(:div, class: 'col-xs-6') do
              builder.text_field_without_bootstrap firstname_att, class: 'form-control'
            end +
              content_tag(:div, class: 'col-xs-6') do
                builder.text_field_without_bootstrap lastname_att, class: 'form-control'
              end
          end
        end
      end
    end

  private

    def builder_has_error?(builder, *attributes)
      attributes.any?{ |att| builder.send(:has_error?, att) }
    end
  end
end

