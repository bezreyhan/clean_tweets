module FavTweetsHelper

  def add_link(tweet)
    new_text = tweet.text.dup
    start = new_text.index("http")
    last = new_text.index(/\s/, start) || new_text.length
    link = new_text.slice!(start..last)
    new_text = new_text.insert(start, "#{link_to link, tweet.attrs[:entities][:urls].first[:expanded_url] }" )
    return new_text
  end

end
