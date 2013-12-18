ActiveAdmin.register Order do
  
  permit_params :name, :ship_street_address, :ship_city, :ship_state, :ship_country, :telephone, :email
  
  form do |f|
    f.inputs 'Details' do
      f.input :ship_country, :as => :string
    end
    f.actions
  end
  
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
