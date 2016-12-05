def select_from_dict(dict, item)
	Hash[File.read("data/#{dict}").split("\n").map { |x| x.split ":" }][item] || "<<ERROR: no #{dict} for #{item}>>"
end

def select_from_file(name, selections = {})
	File.read("data/#{name}").split("\n").sample
		.gsub(/\%([a-z]+)/) do
			type = $1
			value = select_from_file type, selections
			selections[type] = value unless selections[type]
			value
		end
		.gsub(/\$([a-z]+):([a-z]+)/) do
			source_type = $1
			attr = $2
			select_from_dict(attr, selections[source_type])
		end
end

def draminate
	select_from_file 'patterns'
end
