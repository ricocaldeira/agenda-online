class ContactFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact_field, only: [:show, :edit, :update, :destroy]

  def new
    @contact_field = ContactField.new
  end

  def edit
  end

  def create
    @contact_field = ContactField.new(contact_field_params)

    respond_to do |format|
      if @contact_field.save
        format.html { redirect_to @contact_field, notice: 'Contact field was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact_field.update(contact_field_params)
        format.html { redirect_to @contact_field, notice: 'Contact field was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @contact_field.destroy
    respond_to do |format|
      format.html { redirect_to contact_fields_url, notice: 'Contact field was successfully destroyed.' }
    end
  end

  private
    def set_contact_field
      @contact_field = ContactField.find(params[:id])
    end

    def contact_field_params
      params.require(:contact_field).permit(:name, :field_type, :required, :contact_schema_id)
    end
end
