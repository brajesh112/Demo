ActiveAdmin.register BxBlockSpecialization::Specialization, as: "Specialization" do
  active_admin_import
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :specialization_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:specialization_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
