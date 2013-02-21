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
    body = params[:body]
    #puts "body:#{body}"
    pmatch = /em class=\"tb-rmb-num\">(.*)<\/em>/.match(body)
    price = pmatch[1].to_f
    attributes = ProductPageParser.parse(opt);
    render :json => {:attributes => [{:key => 'price', :value => price}]}
  end

private
  def parse_attributes(opt)
    url = opt[:url]
    title = opt[:title]
    body = opt[:body]
    
  end
end
