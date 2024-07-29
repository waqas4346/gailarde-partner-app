ActiveAdmin.register Order do
  # Filters
  filter :created_at, as: :date_range, label: 'Timeframe'
  filter :residence_id, as: :select, collection: -> { Residence.pluck(:name, :id).append(['No Residence', 'no_residence']) }, label: 'Residence'

  controller do
    def scoped_collection
      if current_user.partner.present?
        Order.where(partner: current_user.partner)
      else
        Order.none
      end

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

  index do
    panel "Analytics" do
      div class: "analytics_summary" do
        div class: "score_card" do
          h3 "Number of Orders"
          h2 total_orders
        end
        div class: "score_card" do
          h3 "Revenue"
          h2 number_to_currency(total_revenue)
        end
        div class: "score_card" do
          h3 "Anticipated Commission"
          h2 number_to_currency(anticipated_commission)
        end
      end
    end

    selectable_column
    column "Order Number", :order_number
    column "Order Date", :order_date
    column "Order Value" do |order|
      number_to_currency(order.order_value - order.total_refunds)
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

    actions defaults: [:show, :destroy] # Excludes the Edit action
  end

  show do
    attributes_table do
      row :shopify_order_id
      row :status
      row :order_number
      row :order_date
      row :order_value do |order|
        number_to_currency(order.order_value - order.total_refunds)
      end
      row :payment_status
      row :arrival_date

      if current_user.partner.order_info_level.include?("name")
        row :first_name
        row :last_name
      end

      if current_user.partner.order_info_level.include?("email")
        row :email
        row :student_id
      end

      if current_user.partner.order_info_level.include?("address")
        row :company
        row :address_1
        row :address_2
        row :zip_code
        row :city
        row :country
      end

      if current_user.partner.order_info_level.include?("products")
        row :products
      end

      row :cancellation_date
      row :cancellation_reason
      row :fulfillment_status if current_user.partner.show_fulfillment
      row :tracking_number if current_user.partner.show_tracking_number
      row :partner
    end

    panel "Items" do
      table_for order.items do
        column :product_name
        column :sku
        column :quantity
        column :price do |item|
          number_to_currency(item.price)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :shopify_order_id
      f.input :status
      f.input :order_number
      f.input :order_date, as: :datetime_picker
      f.input :order_value
      f.input :currency
      f.input :payment_status
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :company
      f.input :address_1
      f.input :address_2
      f.input :zip_code
      f.input :city
      f.input :country, as: :country_select
      f.input :cancellation_date, as: :datetime_picker
      f.input :cancellation_reason
      f.input :fulfillment_status if current_user.partner.show_fulfillment
      f.input :tracking_number if current_user.partner.show_tracking_number
      f.input :partner, as: :select, collection: Partner.all.map { |p| [p.name, p.id] }
    end

    f.inputs "Items" do
      f.has_many :items, allow_destroy: true, new_record: true do
        item.input :product_name
        item.input :sku
        item.input :quantity
        item.input :price
      end
    end

    f.actions
  end

  permit_params do
    permitted = [:shopify_order_id, :status, :order_number, :order_date, :order_value, :currency, :payment_status,
                  :first_name, :last_name, :email, :company, :address_1, :address_2, :zip_code,
                  :city, :country, :cancellation_date, :cancellation_reason, :fulfillment_status, :tracking_number, :partner_id]
    permitted << { items_attributes: [:id, :product_name, :sku, :quantity, :price, :_destroy] }
    permitted
  end
end
