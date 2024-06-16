class ChangeDiscountCodeInPartners < ActiveRecord::Migration[7.1]
  def up
    change_column :partners, :discount_code, :string, default: ""
    Partner.update_all(discount_code: '')
  end

  def down
    change_column :partners, :discount_code, :boolean
  end
end
