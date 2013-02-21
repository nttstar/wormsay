
class TaobaoParser
  attr_reader :url_regex
  def initialize
    @url_regex = /^item.taobao.com.*$/
  end

  def parse(text)
    attribs = {}
    pmatch = /em class=\"tb-rmb-num\">(.*)<\/em>/.match(text)
    attribs[:price] = pmatch[1].to_f

    return attribs
  end
end
