require 'sinatra'
require './draminate'

get '/' do
	seed = Random.new_seed
	Random.srand(seed)
	erb :drama, locals: {seed: seed}
end

get '/:seed' do
	seed = params[:seed].to_i
	Random.srand(seed)
	erb :drama, locals: {seed: seed}
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
<a href='/<%= seed %>'>Permalink</a> <br>
<a href='https://github.com/Gaelan/MCDrama'>GitHub
