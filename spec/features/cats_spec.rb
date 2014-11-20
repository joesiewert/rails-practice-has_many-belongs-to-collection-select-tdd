require 'rails_helper'

feature 'Cats' do

  before :each do
    @cat = Cat.create!(
      name: 'Nubs'
    )

    @toy1 = Toy.create!(
      name: 'Ball',
      cat_id: @cat.id
    )

    @toy2 = Toy.create!(
      name: 'Mouse',
      cat_id: @cat.id
    )
  end

  scenario 'Cat show page should list the toys that cat owns' do
    visit root_path
    click_on 'Cats'
    click_on @cat.name
    expect(page).to have_content(@toy1.name)
    expect(page).to have_content(@toy2.name)
  end
end
