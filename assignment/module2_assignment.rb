class LineAnalyzer
  attr_reader :content, :line_number, :highest_wf_count, :highest_wf_words

  def initialize(content, line_number)
    @content = content # This is a really really really cool cool you you you
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = []
    self.calculate_word_frequency
  end

  def calculate_word_frequency
    result = []
    split_line = @content.split # ["This", "is", "a", "really", "really", "really", "cool", "cool", "you", "you", "you"]

    split_line.each_index do |index|
      result.push(["#{split_line[index]}", split_line.select { |w| w == split_line[index] }.count] )
    end

    result.uniq! # [["This", 1], ["is", 1], ["a", 1], ["really", 3], ["cool", 2], ["you", 3]]
    result_hash = result.to_h # {"This"=>1, "is"=>1, "a"=>1, "really"=>3, "cool"=>2, "you"=>3}
    result_hash.each do |k, v|
      @highest_wf_words.push(k) if v == result_hash.values.max # = ["really", "you"]
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
      end
    end
  end

  def calculate_line_with_highest_frequency
# Calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
# Store this result in the highest_count_across_lines attribute
# Identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines
#  attribute value determined previously and stores them in highest_count_words_across_lines.
    @highest_count_words_across_lines = []
    @highest_count_across_lines = @analyzers.max_by {|o| o.highest_wf_count}.highest_wf_count.to_i

    @analyzers.each do |o|
      @highest_count_words_across_lines.push(o.highest_wf_words).flatten! if o.highest_wf_count == @highest_count_across_lines #4
    end
    @highest_count_words_across_lines.rotate!
    # @highest_count_words_across_lines
    # p @highest_count_across_lines
  end

  def print_highest_word_frequency_across_lines
    # The following words have the highest word frequency per line:
    # ["word1"] (appears in line #)
    # ["word2", "word3"] (appears in line #)
  end
end
