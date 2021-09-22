require 'rails_helper'

RSpec.feature 'ProductDetails', type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |_n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Clicking on the image of product opens product detail page' do
    visit root_path

    # save_screenshot
    # find image of the product and click
    page.find('article', match: :first).find('header a img').click

    expect(page).to have_css 'article.product-detail'
    # save_screenshot
  end

  scenario 'Clicking on the text of product opens product detail page' do
    visit root_path

    # save_screenshot
    # find image of the product and click
    page.find('article', match: :first).find('header a h4').click

    expect(page).to have_css 'article.product-detail'
    # save_screenshot
  end

  scenario 'Clicking on the detail button of product opens product detail page' do
    visit root_path

    save_screenshot
    # find image of the product and click
    page.find('article', match: :first).find('footer a').click

    expect(page).to have_css 'article.product-detail'
    save_screenshot
  end
end
