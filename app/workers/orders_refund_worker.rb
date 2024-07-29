class OrdersRefundWorker
    include Sidekiq::Worker
  
    def perform(shopify_order_id, refunds)
      order = Order.find_by(shopify_order_id: shopify_order_id)
  
      if order
        # Calculate and update the refund amount
        refund_amount = refunds["transactions"].sum { |transaction| transaction["amount"].to_f }
  
        # Save refund details if necessary
        order.update(total_refunds: order.total_refunds.to_f + refund_amount)
      end
    end
  end
  