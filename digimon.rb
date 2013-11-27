require 'sinatra'
require 'net/dns'
require 'json'
require 'whois'

helpers do
	def dig(url)
		packet = Net::DNS::Resolver.start(url)
		answer = packet.answer
		ips = {:cname => [], :arecord => []}
		packet.each_cname do |cname|
			ips[:cname].push(cname)
		end
		packet.each_address do |ip|
			ips[:arecord].push(ip)
		end
		return ips
	end

	def whois(url)
		whois = Whois::Client.new
		result = whois.lookup(url)
		
		if result.registrar != nil then result.registrar.name else nil end
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

get '/whois.json' do
    @who = whois(params[:url])
    @who.to_json
end

get '/whois/:url' do
    @who = whois(params[:url])
    erb :whois
end