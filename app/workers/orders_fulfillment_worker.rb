class OrdersFulfillmentWorker
    include Sidekiq::Worker
  
    def perform(shopify_order_id, fulfillment_status, fulfillments)
      order = Order.find_by(shopify_order_id: shopify_order_id)
  
      if order
        # Update fulfillment status
        order.update(fulfillment_status: fulfillment_status, status: "fulfilled")
  
        # Update tracking numbers
        tracking_numbers = fulfillments.map { |f| f["tracking_number"] }.reject(&:blank?)
        order.update(tracking_number: tracking_numbers.join(', '))
      end
    end
  end
  