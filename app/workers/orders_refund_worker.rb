class OrdersRefundWorker
    include Sidekiq::Worker
  
    def perform(shopify_order_id, refunds)
      order = Order.find_by(shopify_order_id: shopify_order_id)
  
      if order
        # Calculate and update the refund amount
        refund_amount = refunds.sum { |refund| refund["transactions"].sum { |transaction| transaction["amount"].to_f } }
  
        # Save refund details if necessary
        order.update(total_refunds: refund_amount)
      end
    end
  end
  