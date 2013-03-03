
class DangdangParser
  attr_reader :url_regex
  def initialize
    @url_regex = /^http:\/\/product.dangdang.com.*$/
  end

  def parse(text)
    attribs = {}
    m = /<span.*id=\"salePriceTag\">.*?(\d+\.\d+)<\/span>/.match(text)
    if !m.nil? and m.length==2 and !m[1].nil?
      attribs["price"] = m[1].to_f
    end

    m = /<span.*id=\"gpromoprice\" value=\".*?(\d+\.\d+)\">/.match(text)
    if !m.nil? and m.length==2 and !m[1].nil?
      attribs["price"] = m[1].to_f
    end

    return attribs
  end
end

