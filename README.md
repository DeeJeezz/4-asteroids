# Asteroids

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/deejeezz/4-asteroids/deploy.yaml)
![GitHub Tag](https://img.shields.io/github/v/tag/deejeezz/4-asteroids)

https://20_games_challenge.gitlab.io/games/asteroids/

## Where to play

Itch.io - https://deejeezz.itch.io/asteroids

Github Pages - https://deejeezz.github.io/4-asteroids

## Description

Asteroids was released by Atari in 1979. The game came out one year after Space Invaders, and helped set the pace for the Golden Era of the Arcade. 
Asteroids is famous for its use of Vector Graphics in lieu of sprites.

### A game without pixels
> There were two competing display technologies in the arcade: Vector and Raster graphics.
> CRT displays used an electron beam to illuminate the phosphor layer on a display.
> Raster graphics games (from Latin Rastrum - “rake”) would sweep the beam across the screen line-by-line.
> Vector graphics took direct control of the beam and drew shapes onto the screen.
>
> Displays today use physical pixels (raster), but graphics cards still use vectors to think, especially when working with 3D geometry. You’ll be working with vectors eventually, even if you opt to use sprites for this game.

## Goal:

* Create a player ship. The ship should be able to rotate and thrust. Thrust will accelerate the ship “forward” in the direction that it is facing.
* Add bullets. The player ship will fire in the direction that it is facing. Bullets will disappear after a short while.
* Create three sizes of asteroids.
  * Asteroids will break into smaller asteroids when shot (The smallest will disappear when shot).
  * Asteroids will drift around until they are shot or they collide with the player. If the player collides with an asteroid, they will lose a life.
* Enable screen wrapping. (Objects leaving the top of the screen should enter the bottom, for example)
* Add menus and UI.
* Add sound effects and particle effects.

## Stretch goal:

* Add a flying saucer that enters the screen and shoots at the player from time to time. The saucer should generally aim towards the player, but shouldn’t have too good of aim!
* Add a “hyperspace warp” that moves the player to a random part of the screen. The warp is a last-ditch attempt to dodge an asteroid, but it could place you in a worse predicament!
* Make it your own - This is a great game to add some custom power-ups to.

## Credits

### Sprites

* https://rehandev.itch.io/480-spaceships-topdown-pixel
* https://foozlecc.itch.io/void-environment-pack
* https://dkproductions.itch.io/pixel-art-package-asteroids
* https://ravenmore.itch.io/space-shooter-assets-space-rage

### UI

* https://adwitr.itch.io/button-asset-pack
* https://greenpixels.itch.io/pixel-art-asset-3

### Music

* https://cathran-music.itch.io/space-sci-fi-music

### SFX

* https://acon1tum.itch.io/meteor-blaster
