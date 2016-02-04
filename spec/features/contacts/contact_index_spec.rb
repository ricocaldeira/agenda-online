include Warden::Test::Helpers
Warden.test_mode!

# Feature: Contacts page
#   As a user
#   I want to visit my contacts page
#   So I can see my contacts list data
feature 'Contacts page', :devise do

  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own contacts
  #   Given I am signed in
  #   When I visit the contacts page
  #   Then I see my own contacts
  scenario 'user sees own contacts' do
    contact = FactoryGirl.create(:contact, user_id: @user.id)
    visit contacts_path
    expect(page).to have_content 'Contacts'
    expect(page).to have_content contact.email
  end

  # Scenario: Users cannot see another user's contacts page
  #   Given I am signed in
  #   When I visit the contacts page
  #   Then I am not able to see another user's contacts
  scenario "user cannot see another user's contacts page" do
    another_user = FactoryGirl.create(:user)
    contact = FactoryGirl.create(:contact, user_id: another_user.id)
    visit contacts_path
    expect(page).to have_content 'Contacts'
    expect(page).to_not have_content contact.email
  end

  # Scenario: Visitors cannot see contacts page
  #   Given I am a visitor
  #   When I visit the contacts page
  #   Then I see an 'You need to sign in or sign up' message
  scenario "visitor cannot see contacts page" do
    visit root_path
    click_link 'Sign out'
    visit contacts_path
    expect(page).to have_content 'You need to sign in or sign up'
  end
end
