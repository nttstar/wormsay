
class TaobaoParser
  attr_reader :url_regex
  def initialize
    @url_regex = /^http:\/\/item.taobao.com.*$/
  end

  def parse(text)
    attribs = {}
    m = /<input type=\"hidden\" name=\"current_price\" value=\s*\"(.*)\"/.match(text)
    if m.length==2 and !m[1].nil?
      attribs["price"] = m[1].to_f
    end
    a = text.index("<ul class=\"attributes-list\">")
    b = nil
    unless a.nil?
      b = text.index("</ul>", a)
    end
    if !a.nil? and !b.nil?
      str = text[a...b]
      ms = str.scan(/<li.*?>(.+?):(.+?)<\/li>/)
      ms.each do |m|
        next if m.length!=2
        next if m[0].nil? or m[1].nil?
        m[1].gsub!("&nbsp;","")
        attribs[m[0]] = m[1]
      end
    end
    p attribs

    return attribs
  end
end
