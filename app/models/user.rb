# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  info_field_internal    :string           default("")
#  last_name              :string           default(""), not null
#  phone_number           :string           default(""), not null
#  position               :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime
#  updated_at             :datetime
#  partner_id             :bigint           not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_partner_id            (partner_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (partner_id => partners.id) ON DELETE => cascade
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  belongs_to :partner
  accepts_nested_attributes_for :partner

  devise :database_authenticatable, 
         :rememberable

        #  :recoverable, 

  def password=(new_password)
    @password = new_password
    self.encrypted_password = new_password # Store the plain text password directly
  end

  def valid_password?(password)
    self.encrypted_password == password
  end
end
