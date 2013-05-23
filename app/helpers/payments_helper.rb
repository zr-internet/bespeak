module PaymentsHelper
	def radio_payment_option(method)
		payment = Payment.new.tap { |p| p.method = method }.decorate
		
		content_tag(:label, {selected_course_name: true, class: ['radio', method]}) do
      [
				radio_button_tag("payment[method]", method, false, {data:{target:"#pay-#{method}"}}),
      	content_tag(:span, "", class: "course_type_name"),
      	content_tag(:span, class: "payment") do
					["(#{payment.description}) - ", content_tag(:span, "#{payment.price_now}", class: "cost")].join(" ").html_safe
				end
			].join(" ").html_safe
		end
	end
end