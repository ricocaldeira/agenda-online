include Warden::Test::Helpers
Warden.test_mode!

# Feature: Contact edit
#   As a user
#   I want to edit my contact with dynamic fields
#   So I can change contact's dynamic information
feature 'Dynamic Contact edit', :devise, :js do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @contact_schema = FactoryGirl.create(:contact_schema, user_id: @user.id)
    @contact = FactoryGirl.create(:contact, user_id: @user.id)
    login_as(@user, :scope => :user)
    visit edit_contact_schema_path(@contact_schema)
    click_link('Add Field')
    fill_in('field_name', :with => 'Phone')
    click_button('Update Contact schema')
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes contact phone
  #   Given I am signed in
  #   When I change a contact's phone
  #   Then I see a contact updated message
  scenario 'user changes contact phone' do
    visit edit_contact_path(@contact)
    fill_in 'Phone', :with => '999999999'
    click_button 'Update Contact'
    expect(page).to have_content 'Contact was successfully updated'
  end
end
