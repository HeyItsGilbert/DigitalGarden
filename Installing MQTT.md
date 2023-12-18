```
$> nuget sources add -Name "nuget.org" -Source https://api.nuget.org/v3/index.json
Package source with Name: nuget.org added successfully.
$> nuget install m2mqtt -o .
Feeds used:
  https://api.nuget.org/v3/index.json

Installing package 'm2mqtt' to 'C:\Users\gsanchez\repos\MeetingMqtt\MeetingMqtt\lib'.
  GET https://api.nuget.org/v3/registration5-gz-semver2/m2mqtt/index.json
  OK https://api.nuget.org/v3/registration5-gz-semver2/m2mqtt/index.json 448ms


Attempting to gather dependency information for package 'm2mqtt.4.3.0' with respect to project 'C:\Users\gsanchez\repos\MeetingMqtt\MeetingMqtt\lib', targeting 'Any,Version=v0.0'
Gathering dependency information took 24 ms
Attempting to resolve dependencies for package 'm2mqtt.4.3.0' with DependencyBehavior 'Lowest'
Resolving dependency information took 0 ms
Resolving actions to install package 'm2mqtt.4.3.0'
Resolved actions to install package 'm2mqtt.4.3.0'
Retrieving package 'M2Mqtt 4.3.0' from 'nuget.org'.
  GET https://api.nuget.org/v3-flatcontainer/m2mqtt/4.3.0/m2mqtt.4.3.0.nupkg
  OK https://api.nuget.org/v3-flatcontainer/m2mqtt/4.3.0/m2mqtt.4.3.0.nupkg 110ms
Installed M2Mqtt 4.3.0 from https://api.nuget.org/v3/index.json with content hash 2A1uM20uxuovQKPA0dkZUqD9gUpIMaX7KxdLiVM7IEXdPRL709hGuudHnvlDxm2/6b2LcOjshrYGVG9vdpipag==.
Adding package 'M2Mqtt.4.3.0' to folder 'C:\Users\gsanchez\repos\MeetingMqtt\MeetingMqtt\lib'
Added package 'M2Mqtt.4.3.0' to folder 'C:\Users\gsanchez\repos\MeetingMqtt\MeetingMqtt\lib'
Successfully installed 'M2Mqtt 4.3.0' to C:\Users\gsanchez\repos\MeetingMqtt\MeetingMqtt\lib
Executing nuget actions took 980 ms
```


## References
https://jackgruber.github.io/2019-06-05-ps-mqtt/