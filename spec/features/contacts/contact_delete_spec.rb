include Warden::Test::Helpers
Warden.test_mode!

# Feature: Contact page
#   As a user
#   I want delete a contact
#   So I can remove a contact from my contacts list
feature 'Contact delete', :devise, :js do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create(:contact, user_id: @user.id)
    login_as(@user, :scope => :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User can delete a contact
  #   Given I am signed in
  #   When I delete a contact
  #   Then I should see a contact deleted message
  scenario 'user can delete a contact' do
    visit contacts_path
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "Contact was successfully deleted"
  end
end
