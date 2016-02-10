include Warden::Test::Helpers
Warden.test_mode!

# Feature: Contact Schema page
#   As a user
#   I want to visit my contact schema page
#   So I can see a contact schema for my contacts
feature 'Contact page', :devise do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @contact_schema = FactoryGirl.create(:contact_schema, user_id: @user.id)
    login_as(@user, :scope => :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees a contact schema information
  #   Given I am signed in
  #   When I visit the contact schema page
  #   Then I see contact schema information
  scenario 'user sees contact schema information' do
    visit contact_schema_path(@contact_schema)
    expect(page).to have_content 'Fields'
  end

  # Scenario: Visitors cannot see contacts page
  #   Given I am a visitor
  #   When I visit a contact page
  #   Then I see an 'You need to sign in or sign up' message
  scenario "visitor cannot see contact schema page" do
    visit root_path
    click_link 'Sign out'
    visit contact_schema_path(@contact_schema)
    expect(page).to have_content 'You need to sign in or sign up'
  end

end
