
class JingdongParser
  attr_reader :url_regex
  def initialize
    @url_regex = /^http:\/\/www.360buy.com/product/.*$/
  end

  def parse(text)
    attribs = {}
    puts "text: #{text}"
    ms = text.scan(/<td class=\"tdTitle\">(.*)<\/td><td>(.*)<\/td>/)
    ms.each do |m|
      next if m.length!=2
      next if m[0].nil? or m[1].nil?
      attribs[m[0]] = m[1]
    end
    p attribs

    return attribs
  end
end

