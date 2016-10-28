require "pismo"
class UrlParser

  def self.generate_link(url)
    doc = Pismo::Document.new(url)


doc2 = Nokogiri::HTML(open(url))
@content=doc2.to_html





    Link.create(title: doc.title, url: url,html:@content)
  end


 




end