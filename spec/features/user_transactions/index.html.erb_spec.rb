require 'rails_helper'

RSpec.describe 'user_transactions/index', type: :feature do
  before do
    @user = User.create(name: 'full name', email: 'name@gmail.com', password: 'password')
    @user.save
    login_as(@user)
    @group = Group.create(name: 'group 1', icon: 'icon.png', author: @user)
    @group.save
    @transaction = UserTransaction.create(name: 'transaction 1', amount: 400, author: @user, group_id: @group.id)
    visit group_user_transactions_path(@group.id)
  end

  describe "Visit user_transactions' index page" do
    it 'should have header' do
      expect(page).to have_text('TRANSACTIONS')
    end

    it 'should have transaction name' do
      expect(page).to have_text('transaction 1')
    end
    it 'should have transaction amount' do
      expect(page).to have_text(400)
    end
    it 'should have group total amount' do
      expect(page).to have_text(@group.total_amount)
    end

    it 'should have back link' do
      expect(page).to have_selector(:link_or_button, 'Back to categories', exact: true)
    end

    it 'should have new page link' do
      expect(page).to have_selector(:link_or_button, 'Add a new transaction', exact: true)
    end

    it 'redirect to categories page' do
      click_link('Back to categories', exact: true)
      expect(page).to have_current_path(groups_path)
    end

    it 'redirect to add new transaction' do
      click_link('Add a new transaction', exact: true)
      expect(page).to have_current_path(new_group_user_transaction_path(@group.id))
    end
  end
end
