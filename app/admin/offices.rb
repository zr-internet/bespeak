ActiveAdmin.register Office do
	form do |f|
		f.inputs name: "Office" do
			f.input :name
			f.input :phone
			f.input :address
		end
		f.buttons
	end
end
