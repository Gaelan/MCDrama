require 'sinatra'
require './draminate'

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
