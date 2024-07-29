class OrdersCancelWorker
    include Sidekiq::Worker
  
    def perform(shopify_order_id, cancel_reason)
      order = Order.find_by(shopify_order_id: shopify_order_id)
  
      if order
        # Update the order status to cancelled
        order.update(
          status: 'cancelled',
          cancellation_date: Time.current, # Set the cancellation date to the current time
          cancellation_reason: cancel_reason || 'No reason provided'
        )
      end
    end
  end