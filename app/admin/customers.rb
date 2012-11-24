ActiveAdmin.register Customer do
  form do |f|
		f.inputs name: "Customer" do
			f.input :name
			f.input :email
			f.input :phone
			f.input :password               
      f.input :password_confirmation
		end
		f.buttons
	end
end
