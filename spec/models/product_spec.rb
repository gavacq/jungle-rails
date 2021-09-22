require 'rails_helper'

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should not have a null for name' do
      @category = Category.new(name: 'Stuff')
      @product = Product.create(name: nil, price: 14, quantity: 4, category: @category)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not have a null for price' do
      @category = Category.new(name: 'Stuff')
      @product = Product.create(name: 'John Doe', price: nil, quantity: 4, category: @category)
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not have a null for quantity' do
      @category = Category.new(name: 'Stuff')
      @product = Product.create(name: 'John Doe', price: 14, quantity: nil, category: @category)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not have a null for category' do
      @category = Category.new(name: 'Stuff')
      @product = Product.create(name: 'John Doe', price: 14, quantity: 4, category: nil)
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    it 'should create new product with no error' do
      @category = Category.new(name: 'Stuff')
      @product = Product.create(name: 'John Doe', price: 14, quantity: 4, category: @category)
      expect(@product).to be_valid
    end
  end
end
