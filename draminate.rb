require 'sinatra'

def select_from_file(name)
	File.read("data/#{name}").split("\n").sample
		.gsub(/\%[a-z]+/) { |type| select_from_file type.gsub('%', '') }
end

def draminate
	select_from_file 'patterns'
end

get '/' do
	erb :drama
end

__END__

@@drama
<style>
* {
	text-align: center;
}
.drama { font-size: 32px; }
</style>
<div class='drama'><%= draminate %></div>
<a href='/'>Get more drama!</a> <br>
<a href='https://github.com/Gaelan/MCDrama'>GitHub
