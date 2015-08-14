!SLIDE
# going fast #
## with ruby

!SLIDE
# performance #

!SLIDE
# ruby = slow #

!SLIDE
# ruby ≠ slow #

!SLIDE
![](/file/go.png)

!SLIDE go
    @@@ go
    package main

    import (
      "fmt"
      "net/http"
    )

    func handler(w http.ResponseWriter, r *http.Request) {
      fmt.Fprintf(w, "hello world")
    }

    func main() {
      http.HandleFunc("/", handler)
      http.ListenAndServe(":8080", nil)
    }

!SLIDE bash
    @@@ bash
    $ wrk -t 2 -d 30s http://localhost:8080

      Running 30s test @ http://localhost:8080
        2 threads and 10 connections
        Thread Stats   Avg      Stdev     Max   +/- Stdev
          Latency     1.09ms   12.20ms 303.11ms   99.53%
          Req/Sec    14.41k   543.94    16.88k    86.88%
        863274 requests in 30.10s, 105.38MB read
      Requests/sec:  28679.93
      Transfer/sec:      3.50MB

!SLIDE
![](/file/jruby.png)

!SLIDE
* JRuby 9.0.0.0-pre1
* torquebox 4.0.0.beta1
* cuba 3.4.0
* Java 8u51  

![](/file/torquebox.png)
![](/file/cuba.png)

!SLIDE ruby
    @@@ ruby
    # http://cuba.is
    require "cuba"

    HelloWorld = Cuba.new do
      on default do
        res.write "hello world"
      end
    end

    run HelloWorld

!SLIDE bash
    @@@ bash
    $ wrk -t 2 -d 30s http://localhost:8080

      Running 30s test @ http://localhost:8080
        2 threads and 10 connections
        Thread Stats   Avg      Stdev     Max   +/- Stdev
          Latency   458.57us    1.11ms  26.25ms   97.78%
          Req/Sec    13.72k     2.12k   20.33k    80.17%
        819295 requests in 30.02s, 132.05MB read
      Requests/sec:  27291.44
      Transfer/sec:      4.40MB

!SLIDE
<img src='https://vmfarms.com/static/img/logos/ruby-logo.png' height=350
width=350>

!SLIDE
* MRI 2.2.2
* puma 2.12.3
* cuba 3.4.0

<img src='http://www.cusd80.com/cms/lib6/AZ01001175/Centricity/Shared/Perry%20High/PerryHeadMaster_PMS.jpg' height=250 width=250>
![](/file/cuba.png)

!SLIDE bash
    @@@ bash
    $ wrk -t 2 -d 30s http://localhost:8080

      Running 30s test @ http://localhost:8080
        2 threads and 10 connections
        Thread Stats   Avg      Stdev     Max   +/- Stdev
          Latency     1.33ms    1.62ms  65.59ms   96.52%
          Req/Sec     4.18k   714.87     5.03k    85.50%
        249520 requests in 30.02s, 21.42MB read
      Requests/sec:   8311.78
      Transfer/sec:    730.54KB

!SLIDE
#TL;DR

!SLIDE bullet points incremental
* jvm is good yo
* less stuff = faster
* YMMV

!SLIDE
![](/file/sanic.gif)

