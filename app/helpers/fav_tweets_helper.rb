module FavTweetsHelper

  def add_link(text)
    new_text = text.dup
    start = new_text.index("http")
    last = new_text.index(/\s/, start) || text.length
    link = new_text.slice!(start..last)
    new_text = new_text.insert(start, "#{link_to link, link}" )
    return new_text
  end

end
