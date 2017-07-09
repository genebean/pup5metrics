# pup5metrics

With the release of Puppet 5 the metrics that used to be part of PE are now
available as part of Puppet Open Source. With this in mind I decided to see
what there was to see. This is my playground related to checking it out. As
such, this repo's setup my change over time.


## Running the demo

```
$ cd pup5metrics
$ vagrant up
```


## Links

Once you do the above you can visit the links below to see what's available.

* Puppet Server Developer Dashboard: https://localhost:8140/puppet/experimental/dashboard.html
* Grafana: http://localhost:3000/dashboard/db/puppet-server
  * user: `admin`
  * pass: `admin`
* Graphite: http://localhost:8080

