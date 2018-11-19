module SearchesHelper
  def result_count_message(count, query)
    return nil if query.blank?

    "There are #{count} #{"results".pluralize(count)} for \"#{query}\"."
  end
end