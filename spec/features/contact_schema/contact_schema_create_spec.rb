include Warden::Test::Helpers
Warden.test_mode!

# Feature: Create a Contact Schema
#   As a user
#   I have a default Contact Schema
#   So I can' create a Contact Schema
feature 'Create Contact Schema', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: A new Contact Schema is created after a successful sign up
  #   Given I am a visitor
  #   When I sign up with success
  #   Then a Contact Schema is created for me
  scenario 'creates a contact schema for a new user' do
    sign_up_with('test@example.com', 'please123', 'please123')
    click_link('Contact Fields')
    expect(page).to have_content 'Fields'
  end
end