# About

Flappy Bird game written in Ruby with the awesome [ruby2d](http://www.ruby2d.com/) framework.

![ruby2d_flappy_bird_3](https://user-images.githubusercontent.com/760933/65826039-c0b92480-e254-11e9-91a9-043bf80b3d07.gif)

> Note: the low frame rate here is due to the GIF recording not the game itself.

## Goals

- Learn more about game physics and collision detection;
- Separate game logic from graphics.

## Todo

- [ ] Improve opening scene;
- [ ] Improve game over scene (add medals and best score);
- [ ] Improve bird's flight and fall animations.

PRs are welcome :-)

# Install

Make sure you have installed:

* [simple2d](https://github.com/simple2d/simple2d):

```
brew tap simple2d/tap
brew install simple2d
```

* [ruby2d](https://github.com/ruby2d/ruby2d):

```
gem install ruby2d
```

Then clone the source code to your local:

```
git clone https://github.com/tiagopog/flappy_bird.git
```

## Ubuntu / Debian

```bash
$ sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev libgles2-mesa-dev
$ url='https://raw.githubusercontent.com/simple2d/simple2d/master/bin/simple2d.sh'; which curl > /dev/null && cmd='curl -fsSL' || cmd='wget -qO -'; bash <($cmd $url) install
```

# Play

```
cd flappy_bird
ruby main.rb
```

Bird control:

* Jump: space bar
* Restart (game over): space bar
