# proxin

Easy way to profiling proxy.
Combine proxies and actions for checking health.

##

Example:

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
    :proxy => #<Proxin::Proxy:0x00007f8975992090 @ip="51.158.68.133", @port="8811", @username=nil, @pa>
    :successful_tasks => [
      {
        :action => #<Proxin::Action::HTTPGetter:0x00007f8975a31e10 @uri="https://google.com">,
        :proxy => #<Proxin::Proxy:0x00007f8975992090 @ip="51.158.68.133", @port="8811", @username=nil,>
        :output => #<Proxin::Implementers::HTTPGetterOutput:0x00007f8975a39908 @uri="https://google.co>
      }
    ],
    :failed_tasks => []
  }
]
```