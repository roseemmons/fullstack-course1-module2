class Person
  attr_accessor :first_name, :last_name #have a first_name and last_name attribute with public accessors

  @@people = [] #have a class attribute called `people` that holds an array of objects

  #have an `initialize` method to initialize each instance
  def initialize(first_name, last_name)
    #assign those parameters to instance variables
    @first_name = first_name
    @last_name = last_name

    #add the created instance (self) to people class variable
    @@people << self
  end

  #have a `search` method to locate all people with a matching `last_name`
  def self.search(last_name) #accept a `last_name` parameter
    #search the `people` class attribute for instances with the same `last_name`
    @@people.select { | i | i.last_name == last_name}
  end

  def to_s #have a `to_s` method to return a formatted string of the person's name
    #return a formatted string as `first_name(space)last_name`
    "#{@first_name} #{@last_name}"
  end
end

p1 = Person.new("John", "Smith")
p2 = Person.new("John", "Doe")
p3 = Person.new("Jane", "Smith")
p4 = Person.new("Cool", "Dude")

puts Person.search("Doe")

# Should print out
# => John Smith
# => Jane Smith
