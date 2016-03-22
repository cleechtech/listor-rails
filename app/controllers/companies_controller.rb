class CompaniesController < ApplicationController

  def new
    @page_title = 'Add New Company'
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)

    # Save the company
    if @company.save
      flash[:notice] = "Company Created"
      redirect_to companies_path
    else
      flash[:alert] = "Company Not Created"
      render 'new'
    end
  end

  def update
    @company = Company.find(params[:id])

    # Update the company
    if @company.update(company_params)
      flash[:notice] = "Company Updated"
      redirect_to companies_path
    else
      flash[:alert] = "Company Not Updated"
      render 'edit'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:id])

    # Delete the company
    if @company.destroy
      flash[:notice] = "Company Removed"
      redirect_to companies_path
    else
      flash[:alert] = "Company Not Removed"
      render 'destroy'
    end
  end

  def index
    @companies = Company.all.order(created_at: :desc).paginate(per_page: 10, page: params[:page])
  end

  private

  def company_params
    params.require(:company).permit(:name, :city, :notes)
  end
end
