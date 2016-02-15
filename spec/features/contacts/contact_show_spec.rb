include Warden::Test::Helpers
Warden.test_mode!

# Feature: Contact page
#   As a user
#   I want to visit my contact page
#   So I can see a contact data
feature 'Contact page', :devise do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create(:contact, user_id: @user.id)
    login_as(@user, :scope => :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees a contact information
  #   Given I am signed in
  #   When I visit the contact page
  #   Then I see contact information
  scenario 'user sees contact information' do
    visit contact_path(@contact)
    expect(page).to have_content 'Contact'
    expect(page).to have_content @contact.email
  end

  # Scenario: Visitors cannot see contacts page
  #   Given I am a visitor
  #   When I visit a contact page
  #   Then I see an 'You need to sign in or sign up' message
  scenario "visitor cannot see contacts page" do
    visit root_path
    click_link 'Sign out'
    visit contact_path(@contact)
    expect(page).to have_content 'You need to sign in or sign up'
  end

end
