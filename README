PassengerMonit
==============

This plugin provides means for monitoring Rails application which run under [Passenger][1]
with [Monit][2].

The pid file name (hardcoded) is /var/tmp/rack.X.pid, where X denotes
the instance number.

[1]: http://www.modrails.com/ "Phusion Passenger"
[2]: http://mmonit.com/monit/ "Monit"


Example Monit configuration
===========================

<pre>
check process instance1 with pidfile /var/tmp/rack.1.pid
    group web
    start program = "/bin/true" with timeout 30 seconds
    stop program = "/bin/sh -c 'kill `cat /var/tmp/rack.1.pid`'"
    if totalmem > 120.0 MB for 5 cycles then restart
    if changed pid 2 times within 2 cycles then alert
    if changed ppid 2 times within 2 cycles then alert
</pre>

Bugs and missing features
=========================

1. Only tested with nginx
2. The pid file location is hardcoded
3. Sometimes there are more passenger instances in the air than anticipated,
so when one goes down, there might be first pid file missing, e.g.:
from [rack.1.pid, rack.2.pid] to [rack.1.pid, rack.2.pid, rack.3.pid] to
[rack.2.pid, rack.3.pid] - monit will complain that the first instance is missing.

Copyright (c) 2011 Roman Shterenzon, released under the MIT license
