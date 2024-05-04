# == Schema Information
#
# Table name: partners
#
#  id                                :bigint           not null, primary key
#  active                            :boolean          default(TRUE)
#  banner                            :boolean          default(FALSE)
#  banner_info                       :text             default("")
#  beds                              :integer          default(0)
#  checkout                          :boolean          default(FALSE)
#  checkout_info                     :text             default("")
#  commission                        :decimal(10, 2)   default(0.0)
#  consolidated_email                :string           default("")
#  consolidated_name                 :string           default("")
#  consolidated_number               :string           default("")
#  contact_email                     :string           default(""), not null
#  contact_number                    :string           default(""), not null
#  customer_group                    :string           default("")
#  discount_code                     :boolean          default(FALSE)
#  discount_code_value               :string           default("")
#  extra_internal_info               :text             default("")
#  international_students_percentage :decimal(10, 2)   default(0.0)
#  landing_page                      :string           default("")
#  logo                              :string           default("")
#  main_intake_date                  :datetime
#  name                              :string           default(""), not null
#  order_info_level                  :string
#  parameter                         :string           default(""), not null
#  previous_year_uptake              :decimal(10, 2)   default(0.0)
#  students                          :integer          default(0)
#  working_hours                     :text             default("")
#  created_at                        :datetime
#  updated_at                        :datetime
#  hub_spot_id                       :string           default("")
#
class PartnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :active

  # def attributes(*args)
  #   hash = super
  #   hash.merge(object.attributes.symbolize_keys)
  # end

  has_many :residences

  class ResidenceSerializer < ActiveModel::Serializer
    attributes :id, :name, :active
    has_many :blocks
    has_many :rooms
    has_many :addresses
    class RoomSerializer < ActiveModel::Serializer
      attributes :id, :name
    end

    class AddressSerializer < ActiveModel::Serializer
      attributes :address1, :address2, :city, :zip, :countryCode
    
      def address1
        object.address
      end
    
      def address2
        object.apartment
      end
    
      def zip
        object.postcode
      end
    
      def countryCode
        object.country
      end
    end

    class BlockSerializer < ActiveModel::Serializer
      attributes :id, :name, :active
      has_many :sub_blocks
      has_many :rooms
      has_many :addresses

      class RoomSerializer < ActiveModel::Serializer
        attributes :id, :name
      end

      class AddressSerializer < ActiveModel::Serializer
        attributes :address1, :address2, :city, :zip, :countryCode
      
        def address1
          object.address
        end
      
        def address2
          object.apartment
        end
      
        def zip
          object.postcode
        end
      
        def countryCode
          object.country
        end
      end

      class SubBlockSerializer < ActiveModel::Serializer
        attributes :id, :name, :active
        has_many :rooms
        has_many :addresses
        class RoomSerializer < ActiveModel::Serializer
          attributes :id, :name
        end

        class AddressSerializer < ActiveModel::Serializer
          attributes :address1, :address2, :city, :zip, :countryCode
        
          def address1
            object.address
          end
        
          def address2
            object.apartment
          end
        
          def zip
            object.postcode
          end
        
          def countryCode
            object.country
          end
        end
      end
    end
  end
end
