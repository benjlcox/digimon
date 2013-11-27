require 'sinatra'
require 'net/dns'
require 'json'
require 'whois'

helpers do
	def checkURL(url)
		#regex checks if the url already has www. or is a subdomain
		if (url =~ /w{3}[\.].+|.+[\.].{4,}[\.].+/).nil?
			return url.insert(0,"www.")
		else
			return url
		end
	end

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
		p url
		result = whois.lookup(url)
		
		if result.registrar != nil then result.registrar.name else nil end
	end

end

get '/lookup/:url' do
    checkedURL = checkURL(params[:url])
    @dig = dig(checkedURL)
    erb :lookup
end

get '/lookup.json' do
    checkedURL = checkURL(params[:url])
    @dig = dig(checkedURL)
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