require 'rails_helper'

RSpec.describe Tags, type: :model do
  it 'single element input create Tag' do
    tags = Tags.from_names('tag1')

    expect(tags.size).to eq 1
    expect(tags[0].name).to eq 'tag1'
  end
  it 'two-elements input create Tags' do
    tags = Tags.from_names('tag1,tag2')

    expect(tags[0].name).to eq 'tag1'
    expect(tags[1].name).to eq 'tag2'
  end
  it 'empty input dont create Tags' do
    tags = Tags.from_names('')
    expect(tags).to be_empty
  end
  it 'only one comma input dont create Tags' do
    tags = Tags.from_names(',')
    expect(tags).to be_empty
  end
  it 'only commas input dont create Tags' do
    tags = Tags.from_names(',,')
    expect(tags).to be_empty
  end
  it 'only spaces separated by commas input dont create Tags' do
    tags = Tags.from_names('  ,  ,  ')
    expect(tags).to be_empty
  end
end
