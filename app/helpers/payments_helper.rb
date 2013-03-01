module PaymentsHelper
	def radio_payment_option(method)
		payment = Payment.new.tap { |p| p.method = method }.decorate
		
		content_tag(:label, {selected_course_name: true, class: ['radio']}) do
      [radio_button_tag("payment[method]", method, false, {data:{target:"#pay-#{method}"}}),
      	content_tag(:span, "", class: "course_type_name"),
      	content_tag(:span, "(#{payment.description}) - #{payment.price_now}", class: "payment")].join(" ").html_safe
		end
	end
end