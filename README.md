# proxin

Easy way to profiling proxy.
Combine proxies and actions for magic.
##
```ruby
require "proxin"

proxy = Proxin::Proxy.new(
  ip: "51.158.68.133", 
  port: "8811", 
  username: nil, 
  password: nil
)

action = Proxin::Action::HTTPGetter.new(
  uri: "https://google.com"
)

boiler = Proxin::Boiler.new([proxy], [action])
boiler.call

boiler.conclusion.status
 => "success"

boiler.conclusion.groups.alive
=> [
  {
    :proxy => #<Proxin::Proxy @ip="51.158.68.133", @port="8811", @username=nil, @password=nil>
    :successful_tasks => [
      {
        :action => #<Proxin::Action::HTTPGetter @uri="https://google.com">,
        :proxy => #<Proxin::Proxy @ip="51.158.68.133", @port="8811", @username=nil, @password=nil>,
        :output => #<Proxin::Implementers::HTTPGetterOutput @uri="https://google.com, @status="success", @response_code=200>
      }
    ],
    :failed_tasks => []
  }
]
```