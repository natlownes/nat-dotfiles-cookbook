nat Cookbook
============
This is a Chef cookbook for my dotfiles and the like.  Some nights it's best to stay in, [think back on Philadelphia radio rivalries](http://articles.philly.com/1992-05-04/news/26014014_1_wwfm-society-hill-towers-new-classical-station), read up on [late-night radio formats](http://en.wikipedia.org/wiki/Quiet_storm), and convert a dotfiles repo to a Chef cookbook.

Requirements
------------
No other cookbooks are required.

Attributes
----------

`node[:nat][:packages]` - packages to install on all machines
`node[:nat][:metal][:packages]` - packages to install on non-virtualized
machines
`node[:nat][:gem_packages]` - rubygems packages (i.e. "jist")
`node[:nat][:vim][:plugins]` - an array of paths and urls for vim plugins


Usage
-----
#### nat::default

Install command line things for VMs and bare metal machines alike.

e.g.
Just include `nat` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nat]"
  ]
}
```

#### nat::metal

Install things I want on an actual machine.


Todo
----

* Fix tmux relinking of SSH_AUTH_SOCK 
* More complete setup on OSX?  Right now depends on current state of machiens as
  they are in Time Machine.
