include Warden::Test::Helpers
Warden.test_mode!

# Feature: Contact edit
#   As a user
#   I want to edit my contacts
#   So I can change contact's information
feature 'Contact edit', :devise do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create(:contact, user_id: @user.id)
    login_as(@user, :scope => :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes contact email address
  #   Given I am signed in
  #   When I change a contact's email address
  #   Then I see a contact updated message
  scenario 'user changes contact email address' do
    visit edit_contact_path(@contact)
    fill_in 'Email', :with => 'newemail@contact.com'
    click_button 'Update Contact'
    expect(page).to have_content 'Contact was successfully updated'
  end

  # Scenario: User cannot edit another user's contact
  #   Given I am signed in
  #   When I try to edit another user's contact
  #   Then I can't see contact info
  scenario 'user cannot edit another user\'s contact' do
    visit root_path
    click_link 'Sign out'
    another_user = FactoryGirl.create(:user)
    login_as(another_user, :scope => :user)
    visit edit_contact_path(@contact)
    expect(page).to_not have_content @contact.email
  end

end
