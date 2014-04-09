module FavTweetsHelper

  def add_link(tweet)
    new_text = tweet.text.dup
    num_links = tweet[:text].scan("http").length
    iterator = 1
    idx = 0
    while iterator <= num_links do 
      start = new_text.index("http", idx)
      # find index of white space or use the length of the text
      last = new_text.index(/\s/, start) || new_text.length
      link = new_text.slice!(start..last)
      # if the tweet has pics and we are iterating over the last
      # link, which is always the pic, then we should link to the urls
      # for the image of the pic, else, link to the appropriate url. 
      if tweet.attrs[:entities][:media] != nil && num_links == iterator
        new_text = new_text.insert(start, "#{link_to link, tweet.attrs[:entities][:media].first[:media_url_https] }" )
      else
        new_text = new_text.insert(start, "#{link_to link, tweet.attrs[:entities][:urls][iterator-1][:expanded_url] }" )
      end


      # if tweet.attrs[:entities][:media] == nil
      #   new_text = new_text.insert(start, "#{link_to link, tweet.attrs[:entities][:urls][iterator-1][:expanded_url] }" )
      # else
      #   if num_links == iterator 
      #     new_text = new_text.insert(start, "#{link_to link, tweet.attrs[:entities][:media].first[:media_url_https] }" )
      #   else
      #     new_text = new_text.insert(start, "#{link_to link, tweet.attrs[:entities][:urls][iterator-1][:expanded_url] }" )
      #   end
      # end

      end_of_link = new_text.index("</a>", idx)
      idx = end_of_link + 4
      iterator += 1
    end
    return new_text
  end

end
