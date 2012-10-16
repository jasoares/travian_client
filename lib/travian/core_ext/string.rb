class String
  def symbolize
    self.gsub(' ', '_').gsub("'", '').downcase.to_sym
  end
end unless "".respond_to? :symbolize
