
class AmazoncnParser
  attr_reader :url_regex
  def initialize
    @url_regex = /^http:\/\/www.amazon.cn.*$/
  end

  def parse(text)
    attribs = {}
    puts "text: #{text}"
    m = /<span class=\"price\">.*?(\d+\.\d+)<\/span>/.match(text)
    if m.length==2 and !m[1].nil?
      attribs["price"] = m[1].to_f
    end
    a = text.index("<h2>基本信息</h2>")
    b = nil
    unless a.nil?
      b = text.index("<b>用户评分:</b>", a)
    end
    if !a.nil? and !b.nil?
      str = text[a...b]
      ms = str.scan(/<li>\s*<b>\s*(.+):\s*<\/b>\s*(.+)\s*<\/li>/)
      ms.each do |m|
        next if m.length!=2
        next if m[0].nil? or m[1].nil?
        attribs[m[0]] = m[1]
      end
    end

    a = text.index("<strong>产品信息</strong>")
    b = text.length-1
    if !a.nil? and !b.nil?
      str = text[a...b]
      ms = str.scan(/<div class=\"tsRow\"><span class=\"tsLabel\">(.+?)<\/span><span>(.*?)<\/span><\/div>/)
      ms.each do |m|
        next if m.length!=2
        next if m[0].nil? or m[1].nil?
        attribs[m[0]] = m[1]
      end
    end
    p attribs

    return attribs
  end
end

