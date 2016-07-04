class Admin::ReportsController < AdminController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /admin/reports
  # GET /admin/reports.json
  def index
    @reports = Report.all
  end

  # GET /admin/reports/1
  # GET /admin/reports/1.json
  def show
  end

  # GET /admin/reports/new
  def new
    @report = Report.new
  end

  # GET /admin/reports/1/edit
  def edit
  end

  # POST /admin/reports
  # POST /admin/reports.json
  def create
    @report = Report.new(report_params)

    start_of_month = Time.zone.local(@report.year, @report.month).beginning_of_month.beginning_of_day
    end_of_month = Time.zone.local(@report.year, @report.month).end_of_month.end_of_day
    @report.new_users = User.created_between(start_of_month, end_of_month).count
    @report.number_of_orders = Order.created_between(start_of_month, end_of_month).count
    @report.number_of_quotes = Quote.created_between(start_of_month, end_of_month).count
    @report.number_of_purchases = Purchase.created_between(start_of_month, end_of_month).count
    @report.amount_of_quotes = Quote.created_between(start_of_month, end_of_month).pluck(:subtotal).sum
    @report.amount_of_purchases = Purchase.created_between(start_of_month, end_of_month).pluck(:subtotal).sum

    respond_to do |format|
      if @report.save
        format.html { redirect_to [:admin, @report], notice: 'Report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @report }
      else
        format.html { render action: 'new' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/reports/1
  # PATCH/PUT /admin/reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to [:admin, @report], notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/reports/1
  # DELETE /admin/reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to admin_reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:new_users, :number_of_orders, :number_of_quotes, :number_of_purchases, :amount_of_quotes, :amount_of_purchases, :catalogs_ordered, :month, :year)
    end
end
