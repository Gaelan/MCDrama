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
	erb :drama, locals: {seed: seed.to_s(36), version: current_version, drama: draminate, permalink: false}
end

get '/:version/:seed' do
	seed = params[:seed].to_i(36)
	Random.srand(seed)
	erb :drama, locals: {seed: seed.to_s(36), drama: draminate(params[:version]), version: params[:version], permalink: true}
end

get '/:legacy_seed' do
	seed = params[:legacy_seed].to_i
	version = '6b51081190f6f87d32aa32a52e3c273a7798cebf' # The last version to use this seed format.
	Random.srand(seed)
	erb :drama, locals: {seed: seed.to_s(36), drama: draminate(version), version: version, permalink: true}
end


__END__

@@drama
<!doctype html>
<html>
<head>
<title>MC Drama Generator</title>
<meta charset="utf-8">
<meta name="description" content="<%= drama %>">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="theme-color" content="#111111">

<meta property="og:title" content="MC Drama Generator">
<meta property="og:type" content="website">
<% if permalink %>
<meta property="og:url" content="http://ftb-drama.herokuapp.com/<%= version %>/<%= seed %>">
<meta property="og:description" content="<%= drama %>">
<% else %>
<meta property="og:url" content="http://ftb-drama.herokuapp.com/">
<% end %>
</head>
<body>
<style>
* {
	text-align: center;
}
.drama {
	font-size: 32px;
	min-height: 10ex;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
body {
	color: #111;
	background-color: #eee;
	font-family: "Roboto", "lucida grande", tahoma, verdana, arial, sans-serif;
}
@media (prefers-color-scheme: dark) {
	body {
		color: #eee;
		background-color: #111;
	}
}
a {
	color: #79C;
	text-decoration: none;
}
a:visited {
	color: #88B;
}
a:hover {
	color: white;
}
</style>
<div class='drama'><%= drama %></div>
<a href='/'>Get more drama!</a> <br>
<a href='/<%= version %>/<%= seed %>'>Permalink</a> <br><br>
<a href='https://github.com/Gaelan/MCDrama'>GitHub</a> |
<a href='https://twitter.com/MCDramaLlama'>Twitter</a> |
<a href='https://reddit.com/r/mcdramagen'>Subreddit</a>
</body>
</html>
