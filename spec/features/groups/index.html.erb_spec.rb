require 'rails_helper'

RSpec.describe 'groups/index', type: :feature do
  before do
    @user = User.create(name: 'full name', email: 'name@gmail.com', password: 'password')
    @user.save
    login_as(@user)
    @group = Group.create(name: 'group 1', icon: 'icon.png', author: @user)
    visit groups_path
  end

  describe "Visit groups' index page" do
    it 'should have group header' do
      expect(page).to have_text('CATEGORIES')
    end
    it 'should have group name' do
      expect(page).to have_text('group 1')
    end

    it 'should have group icon' do
      expect(page.find('.icon')['src']).to have_content 'icon.png'
    end

    it 'should have new page link' do
      expect(page).to have_selector(:link_or_button, 'Add a new category', exact: true)
    end

    it 'redirect to transactions page' do
      click_link(@group.name)
      expect(page).to have_current_path(group_user_transactions_path(@group))
    end

    it 'redirect to add new group' do
      click_link('Add a new category', exact: true)
      expect(page).to have_current_path(new_group_path)
    end
  end
end
