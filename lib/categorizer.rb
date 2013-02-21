
class Categorizer
  attr_reader :max_len
  def initialize
    @file = nil
    @max_len = 0
    @dic = {}
    @categories = [""]
  end

  def load(file)
    @file = file
    puts "loading file #{file}"
    IO.readlines(file).each do |line|
      line.strip!
      vec = line.split(',')
      next if vec.size<2
      category = vec[0]
      next if category.start_with? '图书音像'
      keywords = vec.clone
      keywords[0] = keywords[0].split('>').last
      keywords.each do |keyword|
        terms = to_terms(keyword)
        str = ""
        terms.each do |term|
          term.downcase!
          str+=term
        end
        @max_len = terms.size if terms.size>@max_len
        c = @dic[terms]
        if c.nil?
          @dic[terms] = [category]
        else
          @dic[terms] << category
        end
      end
    end
  end

  def get(text)
    terms = to_terms(text)
    keywords = []
    category_map = Hash.new(0)
    categories = []
    start = 0
    while true
      break if start>=terms.size
      len = 1
      category = nil
      match_terms = nil
      while true
        break if start+len>terms.size
        break if len>@max_len
        search_terms = terms[start, len]
        scategory = @dic[search_terms]
        unless scategory.nil?
          category = scategory
          match_terms = search_terms
        end
        len+=1
      end
      if category.nil?
        start+=1
      else
        start+=match_terms.size
        keywords << match_terms.join('')
        category.each do |c|
          category_map[c]+=1
          puts "match #{c}"
        end
      end
    end
    ca = category_map.to_a
    ca.sort! {|x,y| y[1] <=> x[1]}
    unless ca.empty?
      max_score = ca.first[1]
      ca.each do |c|
        score = c[1]
        if score>=max_score*0.5
          categories << c[0]
        end
      end
    end
    
    return keywords, categories
  end

  def to_s

    "#{@file},#{@max_len}"
  end

private
  def to_terms(text)
    terms = text.scan(/(?:\w+)|(?:[\u4e00-\u9fa5])/)

    terms
  end
end
