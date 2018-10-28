module SearchesHelper
  def result_count_message(count, query)
    return nil if count == 0

    "There are #{count} results for \"#{query}\"."
  end
end