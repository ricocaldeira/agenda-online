include Warden::Test::Helpers
Warden.test_mode!

# Feature: Contact Schema edit
#   As a user
#   I want to edit my contact schemas
#   So I can change contact schema
feature 'Contact Schema edit', :devise, :js do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @contact_schema = FactoryGirl.create(:contact_schema, user_id: @user.id)
    login_as(@user, :scope => :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User cannot edit another user's contact schema
  #   Given I am signed in
  #   When I try to edit another user's contact schema
  #   Then I can't see contact schema info
  scenario 'user cannot edit another user\'s contact schema' do
    other_user = FactoryGirl.create(:user)
    login_as(other_user, :scope => :user)
    edit_contact_schema_path(@contact_schema)
    expect(page).to_not have_content @contact_schema.fields
  end

  # Scenario: User changes contact schema fields
  #   Given I am signed in
  #   When I change a contact schema field
  #   Then I see a contact schema updated message
  scenario 'user changes contact schema fields' do
    visit edit_contact_schema_path(@contact_schema)
    fill_in 'Fields', :with => 'NewContactSchemaName'
    click_button 'Update Contact schema'
    expect(page).to have_content 'Contact schema was successfully updated'
  end

end
