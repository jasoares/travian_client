class Fixnum
  def seconds
    self
  end
  alias :second :seconds

  def minutes
    self * 60
  end
  alias :minute :minutes

  def hours
    self * 3600
  end
  alias :hour :hours

  def days
    self * 24 * 3600
  end
  alias :day :days

  def weeks
    self * 7 * 24 * 3600
  end
  alias :week :weeks

  def ago
    Time.now - self
  end

  alias :and :+
end unless 1.respond_to? :seconds