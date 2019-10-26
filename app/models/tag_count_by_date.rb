class TagCountByDate < ApplicationRecord
  # This is a view, so it's readonly
  def readonly?
    true
  end
end
