class ZipcodeMapping < ApplicationRecord

	def self.get_mileage(from_zip, to_zip)
		self.where(start_zip: from_zip, end_zip: to_zip ).first.try(:mileage).try(:to_i)
	end


	# import new zipcode mapping
	# zips=["43002","43004","43016","43017","43026","43054","43064","43065","43068","43074","43081","43082","43085","43109","43110",
	# "43119","43123","43125","43126","43137","43146","43147","43201","43202","43203","43204","43205","43206","43207","43209","43210",
	# "43211","43212","43213","43214","43215","43216","43217","43219","43220","43221","43222","43223","43224","43227","43228","43229","43230","43231","43232","43235","43240"]
	# csv_text = File.read('uec_zipcode_map.csv')
	# csv = CSV.parse(csv_text, :headers => false)

	# (0..51).each do |i|
	#   from_zip = zips[i]
	#   (0...51).each do |j|
	#     to_zip = zips[j]
	#     puts from_zip + "," + to_zip + "," + csv[i][j]
	#     ZipcodeMapping.create(start_zip: from_zip, end_zip: to_zip, mileage: csv[i][j] )
	#   end
	# end
end
