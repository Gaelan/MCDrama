require 'sinatra'
require './draminate'

get '/txt' do
	Random.srand
	draminate
end

get '/txt/:seed' do
	Random.srand(params[:seed].to_i)
	draminate
end

get '/' do
	seed = Random.new_seed
	Random.srand(seed)
	erb :drama, locals: {seed: seed, drama: draminate}
end

get '/:seed' do
	seed = params[:seed].to_i
	Random.srand(seed)
	erb :drama, locals: {seed: seed, drama: draminate}
end


__END__

@@drama
<!doctype html>
<html>
<head>
<meta name='description' content='<%= drama %>'>
</head>
<body>
<style>
* {
	text-align: center;
}
.drama { font-size: 32px; }
</style>
<div class='drama'><%= drama %></div>
<a href='/'>Get more drama!</a> <br>
<a href='/<%= seed %>'>Permalink</a> <br>
<a href='https://github.com/Gaelan/MCDrama'>GitHub
</body>
</html>
