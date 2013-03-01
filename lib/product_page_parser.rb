class ProductPageParser
  def initialize
    top_dir = File.dirname(File.expand_path(__FILE__))
    Dir["#{top_dir}/parsers/*.rb"].each do |file|
      require file
    end
    @parsers = []
    @parsers << TaobaoParser.new
    @parsers << AmazoncnParser.new
  end

  def parse(opt)
    url = opt[:url]
    body = opt[:body]
    puts "url XX:  #{url}"
    parser = get_parser(url)
    return nil if parser.nil?
    #puts "body type: #{body.class}"
    #puts "body: #{body}"

    parser.parse(body)
  end

private

  def get_parser(url)
    @parsers.each do |parser|
      if parser.url_regex.match(url)
        return parser
      end
    end
    return nil
  end
end
