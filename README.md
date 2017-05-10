# Purloin Noise

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Perlin Noise visualisation to LED matrix display

This project renders three-dimensional [perlin noise](https://en.wikipedia.org/wiki/Perlin_noise) to a 2D 12x12 element full colour LED display using the [arduino-lights](https://github.com/craftcodiness/arduino-lights) library to drive the display.

## Install

For ease of installation, simply use `rvm` and `bundler`:

```
bundle install
```

## Usage

This application requires either the LED matrix to be connected to your computer, or one of the [arduino-lights](https://github.com/craftcodiness/arduino-lights) simulators to be running. If the serial port is anything other than `/dev/ttyUSB0` or you are using the emulator, you will need to export the `BLEMU_DEVICE` environment variable to select the appropriate device.

```
bundle exec ruby perloin.rb
```

## Maintainer

This visualisation is maintained by [@edwardmccaughan](https://github.com/edwardmccaughan).

## Contribute

Contributions are welcome! Make the lights all blink!

## License

This code is licensed however Ed wants
