module ApplicationHelper
  # Properly links to resources (which have their own pages) and
  # external resources (which point to external URLs).
  def link_to_resource(resource, html_options = nil, &block)
    if resource.is_a?(Resource)
      link_to resource, html_options, &block
    elsif resource.is_a?(ExternalResource) && resource.url.blank?
      content_tag :div, html_options, &block
    else # External Resource with link
      link_to resource.url, html_options, &block
    end
  end

  # This wrapper around Rails' #truncate method puts the
  # text in a span with a title attribute when the text
  # is truncated. This way the user sees a tooltip when
  # he hovers on the truncated text.
  def truncate_with_tooltip(text, options = {}, &block)
    return if text.blank?

    truncated_text = truncate(text, options, &block)

    if options.key?(:length) && text.length > options[:length]
      return content_tag(:span, truncated_text, title: sanitize(text))
    end

    truncated_text
  end

  # Returns the Bootstrap alert class for the given
  # flash notice type.
  def flash_class(level)
    case level
    when 'notice' then
      'alert-primary'
    when 'success' then
      'alert-success'
    when 'error' then
      'alert-danger'
    when 'alert' then
      'alert-danger'
    else
      'alert-secondary'
    end
  end

  def initial(str)
    str.first.capitalize
  end

  # Returns the reCAPTCHA error.
  def recaptcha_error(obj)
    obj.errors[:base].select { |e| e.downcase.include?('recaptcha') }.first
  end

  def categories_array
    Category.all.to_a
  end

  def category_count
    Category.count
  end

  # Shows the first error for a given field.
  def field_error(obj, field)
    if obj.errors[field].any?
      content_tag :div,
                  obj.errors.messages[field].first,
                  class: 'form-error-message'
    end
  end
end