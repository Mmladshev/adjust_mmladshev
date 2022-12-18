## Description

There are many ways to realize such task. I prefer to use Zabbix + Prometheus combination. Because i worked with them and they can cover any monitoring task.
Also i do not want to reinvent the wheel. We will use 4 Golden Signal with a bit deeper dive in some areas.  

For them we need zabbix agent, node exporter (or maybe we have some custom exporter for our purposes), 10050, 10051, 9000, 9100 ports open but that is quite obviously. 

We will use prometheus to collect all, lets call them "web" metrics. 

> Latency 

Usually the total delay is taken, but this is not always a good choice.It's better to keep track of latency distribution because it's more in line with availability requirements. The percentage of requests that are processed faster than a given threshold is a Common Service Level Indicator (SLI). Here is an example Service Level Objective (SLO) for this SLI. 

*"Within 24 hours, 99% of requests should be processed faster than 1 second"*

> Traffic

To measure traffic, we need to count how many requests it receives every second.Since we collect metrics once a minute, we will not get the exact value for a particular second. But we can calculate the average number of requests per second using the rate and irate functions in Prometheus.

> Errors

The share of obvious errors is easy to calculate - we divide the HTTP 500 responses by the total number of requests. As for traffic, here we use the average value. The interval must be selected the same *as for traffic*. This will make it easier to track traffic with errors in one panel. Let's say the error rate is 10% in the last five minutes and the API is processing 200 requests per second. It is easy to calculate that, on average, there were 20 errors per second.

Here we can go a bit deeper, for example we have something like nginx, what manage our load, or something like ELB in AWS. Anyway we have somewhere log file. In general it is much better to use ELK as log for logs, but i'm not familiar with that unfortunately(there is nginx exporter that is quite useful). But the main idea here that we should track response code amount of requests and the host, visualize that all on dashboard. Our engineer should quickly look at graphs and realize something like "Oh, we have plenty of error from 10.228.50.97 i should check that right now". And for sure we should set up some alerts for that.

> Saturation

The metric shows how heavily your service is being used. This is a system monitoring measure that identifies resources that are most limited (for example, in a system with limited memory, shows memory, in a system with limited I / O, shows the number of I / O). Many systems degrade before they reach 100% usage, so having a usage target is essential.

And now about Zabbix part

We can use any zabbix out-of-the-box template. They really good, but in fact that we have linux and our server playing the proxy role we should care more about:
Everything is a file, even connection. 
1) Descriptors
2) Inodes


Also we should care about more common metrics: 
1) CPU utilization, memory utilization
2) Load 
3) I/O read, write
4) disk utilization
5) Availability of our core processes 
