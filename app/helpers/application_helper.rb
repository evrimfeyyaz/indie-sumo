module ApplicationHelper
  # The original #link_to_if helper does not print out the
  # given block when the condition succeeds, and also does
  # not allow a class option. This method prints out a link
  # if the condition succeeds, and a div if it fails, with
  # the given class in both cases.
  def link_to_block_if(condition, url, success_class: nil, fail_class: nil, &block)
    if condition
      return link_to(url, class: success_class, &block)
    end

    content_tag('div', class: fail_class, &block)
  end

  # This wrapper around Rails' #truncate method puts the
  # text in a span with a title attribute when the text
  # is truncated. This way the user sees a tooltip when
  # he hovers on the truncated text.
  def truncate_with_tooltip(text, options = {}, &block)
    truncated_text = truncate(text, options, &block)

    if options.key?(:length) && text.length > options[:length]
      return content_tag(:span, truncated_text, title: text)
    end

    truncated_text
  end

  # Returns the Bootstrap alert class for the given
  # flash notice type.
  def flash_class(level)
    case level
    when 'notice' then
      'alert alert-primary'
    when 'success' then
      'alert alert-success'
    when 'error' then
      'alert alert-danger'
    when 'alert' then
      'alert alert-danger'
    else
      'alert alert-secondary'
    end
  end
end