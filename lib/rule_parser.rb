
class RuleParser
  Rule = Struct.new(:key, :regex, :key_group, :value_group)
  attr_reader :url_regex
  def initialize(url_regex)
    @url_regex = url_regex
    @rules = []
  end

  def add(key, regex, key_group=nil, value_group=nil)
    @rules << Rule.new(key, regex, key_group, value_group)
  end

  def parse(text)
    result = {}
    @rules.each do |rule|
      matches = text.scan(rule.regex)
      matches.each do |match|
        key = rule.key
        value = nil
        if match.is_a? Array #has group
          unless rule.key_group.nil?
            key = match[rule.key_group]
          end
          value = match[rule.value_group]
        else
          value = match
        end
        result[key] = value
      end
    end

    return result
  end
end

