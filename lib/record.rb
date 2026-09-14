class Record
  def initialize(name, value)
    @name = name
    @value = value
    @date = Time.now
  end

  attr_reader :name, :value
end
