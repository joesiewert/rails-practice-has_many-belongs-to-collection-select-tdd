require 'rails_helper'

feature 'Toys' do

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

  scenario 'Toy index page should list the cat that owns each of the toys listed' do
    visit root_path
    click_on 'Toys'
    expect(page).to have_content(@toy1.name)
    expect(page).to have_content(@toy2.name)
    expect(page).to have_content(@cat.name)
  end

  scenario 'Toy show page should list the cat that owns that toy (toys are not shared)' do
    visit root_path
    click_on 'Toys'
    click_on @toy1.name
    expect(page).to have_content(@cat.name)
  end

  scenario 'Toy new page should have a collection select for all Cats' do
    visit root_path
    click_on 'Toys'
    click_on 'New Toy!'
    select @cat.name, from: 'toy[cat_id]'
  end

  scenario 'Toy new page should create a new toy and cat ownership and list it on the index' do
    visit root_path
    click_on 'Toys'
    click_on 'New Toy!'
    fill_in 'Name', with: 'Lazer Pointer'
    select @cat.name, from: 'toy[cat_id]'
    click_on 'Create Toy'
    expect(page).to have_content(@cat.name)
    expect(page).to have_content('Lazer Pointer')
  end
end
