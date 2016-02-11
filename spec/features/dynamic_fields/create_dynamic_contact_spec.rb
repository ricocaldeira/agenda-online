include Warden::Test::Helpers
Warden.test_mode!

# Feature: Create a Contact with Dynamic Fields
#   As a user
#   I want to create a contact with dynamic fields
#   So I can define a new contact field
feature 'Create Contact with Dynamic Field', :devise, :js do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @contact_schema = FactoryGirl.create(:contact_schema, user_id: @user.id)
    login_as(@user, :scope => :user)

    visit edit_contact_schema_path(@contact_schema)
    click_link('Add Field')
    fill_in('field_name', :with => 'Phone')
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User can create a new contact with dynamic fields
  #   Given I am signed in
  #   When I visit contact schema page
  #   Then I should be able to create a new contact with phone attribute
  scenario 'user can create a new contact type with dynamic fields' do
    click_button('Update Contact schema')
    visit new_contact_path
    fill_in('Name', :with => 'Contact Name')
    fill_in('Email', :with => 'contact@email.com')
    fill_in('Phone', :with => '123123123')
    click_button('Create Contact')
    expect(page).to have_content 'Contact was successfully created'
  end

  # Scenario: User can't create a new contact without a required dynamic field
  #   Given I am signed in
  #   When I visit new contact page
  #   Then I should not be able to create a new contact without required a dynamic field
  scenario 'user can\'t create a new contact without a required dynamic field' do
    page.find_field('Required').click
    click_button('Update Contact schema')
    visit new_contact_path
    fill_in('Name', :with => 'Contact Name')
    fill_in('Email', :with => 'contact@email.com')
    click_button('Create Contact')
    expect(page).to have_content 'Phone must not be blank'
  end
end