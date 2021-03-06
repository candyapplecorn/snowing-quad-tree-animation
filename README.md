# Snowing Quad Tree
A Gosu program featuring a quadtree containing falling snow 

[https://en.wikipedia.org/wiki/Quadtree](https://en.wikipedia.org/wiki/Quadtree)

<img src="assets/snow3.gif">

<img src="assets/snow4.gif">

## Usage

```bash
$ ruby snow.rb
```
Then move the mouse around!

## Installation
After cloning this repository, this programs gems may be installed via bundler by typing ```bundle install```

Gosu is a 2d animation library for Ruby and C++. It may need a few operating-system specific 
steps for installation, which can be found at 
[https://www.libgosu.org/ruby.html](https://www.libgosu.org/ruby.html)

[linux installation instructions](https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux#ubuntu-last-tested-on-yakkety-yak-1610-with-gosu-0112--linux-mint-last-tested-on-linux-mint-173)

[Max install instructions](https://github.com/gosu/gosu/wiki/Getting-Started-on-OS-X): tl;dr: Run ```brew install sdl2``` and _then_ you can successfully ```bundle install```

### to-do
- Fix the buggy quad tree animation
- Create event listeners for keyboard input

