class ZipcodeMapping < ApplicationRecord

	def self.get_mileage(from_zip, to_zip)
		self.where(start_zip: from_zip, end_zip: to_zip ).first.try(:mileage).try(:to_i)
	end
end
