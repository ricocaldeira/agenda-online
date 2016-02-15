include Warden::Test::Helpers
Warden.test_mode!

# Feature: Create a Contact
#   As a user
#   I want to create a contact
#   So I can store contact info on my contacts list
feature 'Create Contact', :devise do

  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    visit contacts_path
    click_link('New Contact')
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Visitors cannot create a contact
  #   Given I am a visitor
  #   When I visit new contact page
  #   Then I see an 'You need to sign in or sign up' message
  scenario 'visitors cannot create a contact' do
    visit root_path
    click_link 'Sign out'
    visit new_contact_path
    expect(page).to have_content 'You need to sign in or sign up'
  end

  # Scenario: User can create a new contact
  #   Given I am signed in
  #   When I visit new contact page
  #   Then I should be able to create a new contact
  scenario 'user can create a new contact' do
    fill_in('Name', :with => 'Contact Name')
    fill_in('Email', :with => 'contact@email.com')
    click_button('Create Contact')
    expect(page).to have_content 'Contact was successfully created'
    expect(page).to have_content 'contact@email.com'
  end

  # Scenario: User can't create a new contact without a name
  #   Given I am signed in
  #   When I visit new contact page
  #   Then I should not be able to create a new contact without a name
  scenario 'user can\'t create a new contact without a name' do
    click_button('Create Contact')
    expect(page).to have_content 'Name can\'t be blank'
  end
end