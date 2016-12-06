require 'sinatra'
require 'json'
require './draminate'

get '/txt' do
	Random.srand
	draminate
end

get '/txt/:version/:seed' do
	Random.srand(params[:seed].to_i(36))
	draminate params[:version]
end

get '/json' do
	seed = Random.new_seed
	version = current_version
	Random.srand(seed)
	{seed: seed.to_s(36), drama: draminate, version: version}.to_json
end

get '/json/:version/:seed' do
	seed = params[:seed].to_i(36)
	Random.srand(seed)
	{seed: seed.to_s(36), drama: draminate(params[:version]), version: params[:version]}.to_json
end

get '/' do
	seed = Random.new_seed
	Random.srand(seed)
	erb :drama, locals: {seed: seed.to_s(36), version: current_version, drama: draminate}
end

get '/:version/:seed' do
	seed = params[:seed].to_i(36)
	Random.srand(seed)
	erb :drama, locals: {seed: seed.to_s(36), drama: draminate(params[:version]), version: params[:version]}
end

get '/:legacy_seed' do
	seed = params[:legacy_seed].to_i
	version = '6b51081190f6f87d32aa32a52e3c273a7798cebf' # The last version to use this seed format.
	Random.srand(seed)
	erb :drama, locals: {seed: seed.to_s(36), drama: draminate(version), version: version}
end


__END__

@@drama
<!doctype html>
<html>
<head>
<meta name='description' content="<%= drama %>">
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
<a href='/<%= version %>/<%= seed %>'>Permalink</a> <br>
<a href='https://github.com/Gaelan/MCDrama'>GitHub
</body>
</html>
