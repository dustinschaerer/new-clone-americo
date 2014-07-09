ActiveAdmin.register User do

  menu :priority => 8

  permit_params :id, :email, :created_at, :sign_in_count, :last_sign_in_at, :last_sign_in_ip, :admin

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
