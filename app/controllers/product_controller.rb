require 'product_page_parser'
class ProductController < ApplicationController
  def categorization
    categorizer = Wormsay::Application::CATEGORIZER
    puts categorizer
    query = params[:q]
    keywords, categories = categorizer.get(query)
    puts "keywords #{keywords}"
    puts "categories #{categories}"
    render json: {:keywords => keywords, :categories => categories}
  end

  def browser_search
    parser = Wormsay::Application::PAGE_PARSER
    #body = params[:body]
    #puts "body:#{body}"
    #pmatch = /em class=\"tb-rmb-num\">(.*)<\/em>/.match(body)
    #price = pmatch[1].to_f
    attributes = parser.parse(params);
    render :json => {:attributes => attributes}
  end

private
  def parse_attributes(opt)
    url = opt[:url]
    title = opt[:title]
    body = opt[:body]
    
  end
end
