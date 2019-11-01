class BundledTag < ApplicationRecord
    belongs_to :tag_bundle
    belongs_to :tag
end
