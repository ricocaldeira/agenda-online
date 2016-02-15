class ContactSchemasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact_schema, only: [:show, :edit, :update]

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @contact_schema.update(contact_schema_params)
        format.html { redirect_to @contact_schema, notice: 'Contact schema was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def set_contact_schema
      @contact_schema = current_user.contact_schema
    end

    def contact_schema_params
      params.require(:contact_schema).permit(:user_id, :fields_attributes).tap do |whitelisted|
        whitelisted[:fields_attributes] = params[:contact_schema][:fields_attributes]
      end
    end
end
