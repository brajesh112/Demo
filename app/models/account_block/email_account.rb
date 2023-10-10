module AccountBlock
	class EmailAccount < Account
		self.table_name_prefix = "account_block_"
	end
end