require 'rails_helper'

RSpec.describe 'groups/new', type: :feature do
  before do
    @user = User.create(name: 'full name', email: 'name@gmail.com', password: 'password')
    @user.save
    login_as(@user)
    visit new_group_path
    fill_in placeholder: 'Category name', with: 'group 2'
    find('.select-icon').find(:xpath, 'option[2]').select_option
  end

  describe "Visit groups' new page" do
    it 'should have group header' do
      expect(page).to have_text('NEW CATEGORY')
    end

    it 'should have save button' do
      expect(page).to have_selector(:link_or_button, 'Save category', exact: true)
    end

    it 'should have back link' do
      expect(page).to have_selector(:link_or_button, 'Back to Categories', exact: true)
    end

    it 'redirect to groups page' do
      click_link('Back to Categories', exact: true)
      expect(page).to have_current_path(groups_path)
    end
  end

  it 'should create group and redirect to groups page' do
    click_button('Save category', exact: true)
    expect(page).to have_current_path(groups_path)
    expect(page).to have_text('Group was successfully created')
  end
end
