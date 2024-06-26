class ChangeContactFieldsToAllowNullInResidences < ActiveRecord::Migration[7.1]
  def change
    change_column_null :residences, :contact_email, true
    change_column_null :residences, :contact_name, true
    change_column_null :residences, :contact_phone, true
  end
end
