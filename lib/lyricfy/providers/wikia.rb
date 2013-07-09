module Lyricfy
  class Wikia < Lyricfy::LyricProvider
    include URIHelper

    def initialize(parameters)
      super(parameters)
      self.base_url = "http://lyrics.wikia.com/"
      self.url = URI.escape(self.base_url + format_parameters)
    end

    def search
      if data = super
        html = Nokogiri::HTML(data)
        html_to_array(html)
      end
    end

    private

    def format_parameters
      artist_name = tilde_to_vocal(self.parameters[:artist_name]).gsub(" ", "_")
      song_name = tilde_to_vocal(self.parameters[:song_name]).gsub(" ", "_")
      "#{artist_name}:#{song_name}"
    end

    def html_to_array(html)
      container = html.css('div.lyricbox').first
      if container
        elements = container.children.to_a
        paragraphs = elements.select { |ele| ele.text? || (ele.name == 'br') }
        paragraphs.compact.map{|x| x.text.empty?? "\n" : x.text.strip }
      end
    end
  end
end