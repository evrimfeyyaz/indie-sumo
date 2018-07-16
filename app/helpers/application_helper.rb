module ApplicationHelper
  # The original #link_to_if helper does not print out the given block
  # when the condition succeeds, and also does not allow a class option.
  # This method prints out a link if the condition succeeds, and a div if
  # it fails, with the given class in both cases.
  def link_to_block_if(condition, url, success_class: nil, fail_class: nil, &block)
    if condition
      return link_to(url, class: success_class, &block)
    end

    content_tag('div', class: fail_class, &block)
  end
end