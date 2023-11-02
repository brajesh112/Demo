class RazorpayPayment
	class << self 
		def create_order(amount,id,type)
			Razorpay::Order.create amount: amount, currency: 'INR', receipt: "TEST##{type}#{id}"
		end
	end
end