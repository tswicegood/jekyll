require 'atom/feed'
require 'open-uri'

module Atom
  class Feed
    def to_liquid
      { "entries" => self.entries,
        "title" => self.title,
      }
    end
  end

  class Entry
    def to_liquid
      { "content" => self.content,
        "published" => self.published.strftime("%d %B %Y"),
        "title" => self.title,
      }
    end
  end

  class Title
    def to_liquid
      self.to_s
    end
  end
  
  class Content
    def to_liquid
      self.to_s
    end
  end
end

  class AtomParser < Liquid::Tag
    def initialize(tag_name, url, tokens)
      @url = url.strip
    end

    def render(context)
      feed = Atom::Feed.new @url
      feed.update!
      context["feed"] = feed
      ""
    end
  end


module Jekyll

  class AtomParser < Liquid::Tag
    def initialize(tag_name, url, tokens)
      @url = url.strip
    end

    def render(context)
      feed = Atom::Feed.new @url
      feed.update!
      context["feed"] = feed
      ""
    end
  end

end

Liquid::Template.register_tag('atom', Jekyll::AtomParser)
