require 'razorpay'

Razorpay.setup(ENV["razorpay_key_id"],ENV['razorpay_secret_token'])
order = Razorpay::Order.create amount: 50000, currency: 'INR', receipt: 'TEST'