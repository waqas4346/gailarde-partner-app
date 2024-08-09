ActiveAdmin.register Order do
  actions :all, except: [:new]

  config.batch_actions = false

  # Filters
  filter :order_date, as: :date_range, label: 'Timeframe'
  filter :residence_id, as: :select, 
       collection: -> { [['No Residence', ''], *current_user.partner.residences.pluck(:name, :id)] },
       label: 'Residence',
       include_blank: false


  controller do
    def scoped_collection
      if current_user.partner.present?
        orders = Order.where(partner: current_user.partner)
        filters = params[:q] || {}

        apply_filters(orders, filters)
      else
        Order.none
      end
    end

    def apply_filters(scope, filters)
      filters.each do |key, value|
        case key
        when 'order_date_gteq'
          scope = scope.where('order_date >= ?', value) if value.present?
        when 'order_date_lteq'
          scope = scope.where('order_date <= ?', value) if value.present?
        when 'residence_id_eq'
          if value == 'no_residence'
            scope = scope.where(residence_id: nil)
          else
            scope = scope.where(residence_id: value)
          end
        end
      end
      scope
    end

    def index
      @order_info_level = current_user.partner.order_info_level if current_user.partner.present?
      @total_orders = scoped_collection.count
      @total_revenue = scoped_collection.where.not(status: 'cancelled').sum { |order| order.order_value - order.total_refunds }
      @anticipated_commission = calculate_anticipated_commission
      super
    end

    private

    def calculate_anticipated_commission
      if current_user.partner.present?
        commission_rate = current_user.partner.commission.to_f
        @total_revenue * (commission_rate / 100)
      else
        0
      end
    end
  end

  index download_links: [:csv] do
    panel "Analytics" do
      div class: "analytics_summary" do
        div class: "score_card" do
          h3 "Number of Orders"
          h2 total_orders
        end
        div class: "score_card" do
          h3 "Revenue"
          h2 number_to_currency(total_revenue, unit: "£")
        end
        div class: "score_card" do
          h3 "Anticipated Commission"
          h2 number_to_currency(anticipated_commission, unit: "£")
        end
      end
    end

    selectable_column
    column "Order Number", :order_number
    column "Order Date", :order_date
    column "Order Value" do |order|
      number_to_currency(order.order_value - order.total_refunds, unit: "£")
    end
    column "Payment Status", :payment_status

    if current_user.partner.order_info_level.include?("name")
      column "First Name", :first_name
      column "Last Name", :last_name
    end

    if current_user.partner.order_info_level.include?("email")
      column "Email", :email
      column "Student ID", :student_id
    end

    if current_user.partner.order_info_level.include?("address")
      column "Company", :company
      column "Address 1", :address_1
      column "Address 2", :address_2
      column "ZIP Code", :zip_code
      column "City", :city
      column "Country", :country
    end

    if current_user.partner.order_info_level.include?("products")
      column "Products", :products
    end

    if current_user.partner.show_fulfillment
      column "Fulfillment Status", :fulfillment_status
    end

    if current_user.partner.show_tracking_number
      column "Tracking Number" do |order|
        order.tracking_number.split(',').join(', ')
      end
    end
  end

  csv do
    column "Order Number", &:order_number
    column "Order Date", &:order_date
    column "Order Value" do |order|
      order.order_value - order.total_refunds
    end
    column "Payment Status", &:payment_status

    if current_user.partner.order_info_level.include?("name")
      column "First Name", &:first_name
      column "Last Name", &:last_name
    end

    if current_user.partner.order_info_level.include?("email")
      column "Email", &:email
      column "Student ID", &:student_id
    end

    if current_user.partner.order_info_level.include?("address")
      column "Company", &:company
      column "Address 1", &:address_1
      column "Address 2", &:address_2
      column "ZIP Code", &:zip_code
      column "City", &:city
      column "Country", &:country
    end

    if current_user.partner.order_info_level.include?("products")
      column "Products", &:products
    end

    if current_user.partner.show_fulfillment
      column "Fulfillment Status", &:fulfillment_status
    end

    if current_user.partner.show_tracking_number
      column "Tracking Number" do |order|
        order.tracking_number.split(',').join(', ')
      end
    end
  end

  permit_params do
    permitted = [:shopify_order_id, :status, :order_number, :order_date, :order_value, :currency, :payment_status,
                 :first_name, :last_name, :email, :company, :address_1, :address_2, :zip_code,
                 :city, :country, :cancellation_date, :cancellation_reason, :fulfillment_status, :tracking_number, :partner_id]
    permitted << { items_attributes: [:id, :product_name, :sku, :quantity, :price, :_destroy] }
    permitted
  end
end
