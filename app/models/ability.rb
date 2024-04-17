class Ability
  # include CanCan::Ability

  # def initialize(user)
  #   return unless user

  #   case user.role
  #   when 'admin'
  #     can :manage, :all
  #   when 'partner'
  #     can [:read, :update], Partner, admin_user_id: user.id
  #   end
  # end
end