class Tags
  def self.from_names(joined_tag_names)
    tag_names = joined_tag_names.split(',').map{ |n| n.strip}
    tag_names.map {|name| Tag.find_or_create_by(name: name) }
  end
end
