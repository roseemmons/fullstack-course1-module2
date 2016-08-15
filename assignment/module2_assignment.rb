class LineAnalyzer
  attr_reader :content, :line_number, :highest_wf_count, :highest_wf_words

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = []
    self.calculate_word_frequency
  end

  def calculate_word_frequency
    result = []
    split_line = @content.split

    split_line.each_index do |index|
      result.push(["#{split_line[index]}", split_line.select { |w| w == split_line[index] }.count] )
    end

    result.uniq!
    result_hash = result.to_h
    result_hash.each do |k, v|
      @highest_wf_words.push(k) if v == result_hash.values.max
      @highest_wf_count = result_hash.values.max # = 3
    end
  end
end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
    @highest_count_across_lines = nil
    @highest_count_words_across_lines = nil
  end

  def analyze_file
    #* Load the 'test.txt' file in lines
    #* Create an array of LineAnalyzers for each line in the file
    text_file='test.txt'
    if File.exist? text_file
      File.readlines(text_file).each_with_index do |line, index|
        clean_line = line.chomp.downcase!
        @analyzers.push(LineAnalyzer.new(clean_line, index))
        @analyzers.reverse!
      end
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_across_lines = @analyzers.collect { |o| o.highest_wf_count }.max
    @highest_count_words_across_lines = @analyzers.reject{|o| o.highest_wf_count != @highest_count_across_lines}
 end

  def print_highest_word_frequency_across_lines
    # The following words have the highest word frequency per line:
    # ["word1"] (appears in line #)
    # ["word2", "word3"] (appears in line #)
  end
end
