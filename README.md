digimon
=======

@borkborkNFork seems to think this needs  Readme. 

Digimon is a rediculously small Sinatra app that does nothing but return DNS addresses and Domain registrars over a json API (though there are basic views). 

Usage is simple:
    
    For Dig just hit /lookup.json?url=google.com for JSON or /lookup/google.com for the HTML view
    
    For Whois registrar name just hit /whois.json?url=google.com for JSON or /whois/google.com for the HTML view
