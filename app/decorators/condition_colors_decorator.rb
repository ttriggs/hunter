class ConditionColorsDecorator
  def self.color_class(condition)
    new(condition).color_class
  end

  def initialize(condition)
    @condition = condition
  end

  def color_class
    @condition.gsub(" ","").underscore
  end
end
