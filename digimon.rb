require 'sinatra'
require 'net/dns'
require 'json'
require 'haml'

helpers do
	def dig(url)
		packet = Net::DNS::Resolver.start(url)
		answer = packet.answer
		ips = {:cname => [], :arecord => []}
		packet.each_cname do |cname|
			ips[:cname].push("c => #{cname}")
		end
		packet.each_address do |ip|
			ips[:arecord].push("a => #{ip}")
		end
		return ips
	end
end

get '/lookup/:url' do
    @dig = dig(params[:url])
    erb :lookup
end

get '/lookup.json' do
    @dig = dig(params[:url])
    @dig.to_json
end