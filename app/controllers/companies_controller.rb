class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    zip=company_params["zip_code"]
    city_state_blob = get_city_state(zip) rescue nil
    @company.city_state_blob = city_state_blob
    if @company.save
      # debugger
      redirect_to companies_path, notice: "Saved"
    else
      render :new
    end
  end

  def edit
  end

  def update
    zip=company_params["zip_code"]
    city_state_blob = get_city_state(zip) rescue nil
    @company.city_state_blob = city_state_blob
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.html {redirect_to companies_url, notice: 'Company was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  def get_city_state(zip_code_number)
    city_state_data = {}
    zip_db = ZipCodes.identify(zip_code_number)
    city_state_data['state'] = zip_db[:state_code]
    city_state_data['city'] = zip_db[:city]
    city_state_data
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end

end
