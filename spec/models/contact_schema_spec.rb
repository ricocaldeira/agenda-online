describe ContactSchema do

  before(:each) { @contact_schema = ContactSchema.new(fields: 'myfield') }

  subject { @contact_schema }

  it { should respond_to(:fields) }

  it "#fields returns a string" do
    expect(@contact_schema.fields).to match 'myfield'
  end

end
