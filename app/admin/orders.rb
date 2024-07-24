ActiveAdmin.register Order do
    # Filter configuration
    filter :shopify_order_id
    filter :status
    filter :order_number
    filter :order_date
    filter :payment_status
    filter :partner
    filter :fulfillment_status
    filter :tracking_number
  
    # Index view
    index do
      selectable_column
      id_column
      column :status
      column "Order Number", :order_number
      column "Order Date", :order_date
      column "Order Value" do |order|
        number_to_currency(order.order_value)
      end
      column "Payment Status", :payment_status
      column "First Name", :first_name
      column "Last Name", :last_name
      column "Email", :email
      column "Company", :company
      column "Address 1", :address_1
      column "Address 2", :address_2
      column "ZIP Code", :zip_code
      column "City", :city
      column "Products" do |order|
        order.items.map { |item| "#{item.quantity}x #{item.product_name} | #{item.sku}" }.join("<br>").html_safe
      end
      column "Fulfillment Status", :fulfillment_status
      column "Tracking Number" do |order|
        order.tracking_number.split(',').join(', ')
      end
      actions
    end
  
    # Show view
    show do
      attributes_table do
        row :shopify_order_id
        row :status
        row :order_number
        row :order_date
        row :order_value do |order|
          number_to_currency(order.order_value)
        end
        row :payment_status
        row :first_name
        row :last_name
        row :email
        row :company
        row :address_1
        row :address_2
        row :zip_code
        row :city
        row :fulfillment_status
        row :tracking_number
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
  
    # Form view
    form do |f|
      f.semantic_errors
  
      f.inputs do
        f.input :shopify_order_id
        f.input :status
        f.input :order_number
        f.input :order_date, as: :datetime_picker
        f.input :order_value
        f.input :payment_status
        f.input :first_name
        f.input :last_name
        f.input :email
        f.input :company
        f.input :address_1
        f.input :address_2
        f.input :zip_code
        f.input :city
        f.input :fulfillment_status
        f.input :tracking_number
        f.input :partner, as: :select, collection: Partner.all.map { |p| [p.name, p.id] }
      end
  
      f.inputs "Items" do
        f.has_many :items, allow_destroy: true, new_record: true do |item|
          item.object ||= f.object.items.build if item.object.nil?
          item.input :product_name
          item.input :sku
          item.input :quantity
          item.input :price
        end
      end
  
      f.actions
    end
  
    # Permit parameters
    permit_params do
      permitted = [:shopify_order_id, :status, :order_number, :order_date, :order_value, :payment_status,
                    :first_name, :last_name, :email, :company, :address_1, :address_2, :zip_code,
                    :city, :fulfillment_status, :tracking_number, :partner_id]
      permitted << { items_attributes: [:id, :product_name, :sku, :quantity, :price, :_destroy] }
      permitted
    end
  end
  