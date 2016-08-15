class LineAnalyzer
  attr_reader :content, :line_number, :highest_wf_count, :highest_wf_words

  def initialize(content, line_number)
    @content = content # Visual note: "This is a really really really cool cool you you you"
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = []
    self.calculate_word_frequency
  end

  def calculate_word_frequency
    result = []
    split_line = @content.split
    # Visual note: ["This", "is", "a", "really", "really", "really", "cool", "cool", "you", "you", "you"]

    split_line.each_index do |index|
      result.push(["#{split_line[index]}", split_line.select { |w| w == split_line[index] }.count] )
    end
    # Visual note: [["This", 1], ["is", 1], ["a", 1], ["really", 3], ["really", 3], ["really", 3], ["cool", 2], ["cool", 2], ["you", 3], ["you", 3], ["you", 3]]

    result.uniq! # Visual note: [["This", 1], ["is", 1], ["a", 1], ["really", 3], ["cool", 2], ["you", 3]]

    result_hash = result.to_h
    result_hash.each do |k, v|
      # If the currently-evaluated value equals the hashe's max value, push the key to @highest_wf_words:
      @highest_wf_words.push(k) if v == result_hash.values.max # Visual note: ["really", "you"]

      # Check the hash for its highest value, and assign it to @highest_wf_count:
      @highest_wf_count = result_hash.values.max # Visual note: 3
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
    text_file='test.txt'
    if File.exist? text_file
      File.readlines(text_file).each_with_index do |line, index|
        clean_line = line.chomp.downcase!
        @analyzers.push(LineAnalyzer.new(clean_line, index))
      end
    end
  end

  def calculate_line_with_highest_frequency
    # Loop through all LineAnalyzer objects and find the highest @highest_wf_count value:
    @highest_count_across_lines = @analyzers.collect { |o| o.highest_wf_count }.max

    # Loop through all LineAnalyzer objects and find only the objects that match the max word count:
    @highest_count_words_across_lines = @analyzers.select{ |o| o.highest_wf_count == @highest_count_across_lines }
 end

  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each do |o|
      puts "#{o.highest_wf_words} appears in line #{o.line_number}"
    end
  end
end
