require 'rails_helper'

RSpec.describe 'user_transactions/new', type: :feature do
  before do
    @user = User.create(name: 'full name', email: 'name@gmail.com', password: 'password')
    @user.save
    @group = Group.create(name: 'group 1', icon: 'icon.png', author: @user)
    @group.save
    login_as(@user)
    visit new_group_user_transaction_path(@group.id)
    fill_in placeholder: 'Transaction name', with: 'transaction 2'
    fill_in placeholder: 'Transaction amount', with: 120
  end

  describe "Visit user_transactions' new page" do
    it 'should have transaction header' do
      expect(page).to have_text('NEW TRANSACTION')
    end

    it 'should have save button' do
      expect(page).to have_selector(:link_or_button, 'Save transaction', exact: true)
    end

    it 'should have back link' do
      expect(page).to have_selector(:link_or_button, 'Back to Transactions', exact: true)
    end

    it 'redirect to user_transactions page' do
      click_link('Back to Transactions', exact: true)
      expect(page).to have_current_path(group_user_transactions_path(@group.id))
    end
  end

  it 'should create group and redirect to user_transactions page' do
    click_button('Save transaction', exact: true)
    expect(page).to have_current_path(group_user_transactions_path(@group.id))
    expect(page).to have_text('User transaction was successfully created')
  end
end
