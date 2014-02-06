#= require Splash
#= require Landscape

LaggyDash = window.LaggyDash

Splash = LaggyDash.Splash
Landscape = LaggyDash.Landscape

class Main extends Phaser.State
  constructor:(@parent='')->

  run:(debug = false)->
    mode = if debug then Phaser.CANVAS else Phaser.AUTO
    new Phaser.Game(896, 504, mode, @parent, this)

  destroy:->
    destroy(@text)
    destroy(@graphics)

  preload:->  
    @game.stage.scaleMode = Phaser.StageScaleMode.EXACT_FIT
    @game.stage.scale.setShowAll()
    @game.stage.scale.refresh()

    message = "=== L A G G Y D A S H ===\nis\nLOADING"
    style =
      font: "30px Courier"
      fill: "#00ff44"
      align: "center"
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, message, style)
    @text.anchor.setTo(0.5, 0.5)
    @graphics = @game.add.graphics(0, 0)

    @graphics.lineStyle(1, 0x5588cc, 1)
    @graphics.drawRect(199, 339, 502, 22)

    @game.load.onLoadComplete.addOnce(@ready)
    @game.state.add('splash', new Splash(), false)
    @game.state.add('landscape', new Landscape(), false)
    @game.load.image('labs', 'assets/labs.png')
    @game.load.image('sky', 'assets/sky.jpg')
    @game.load.image('sun', 'assets/sun.png')
    @game.load.image('cloud', 'assets/cloud.png')
    @game.load.image('mountain', 'assets/mountain.png')
    @game.load.image('grass', 'assets/grass.png')
    @game.load.image('tree1', 'assets/tree1.png')
    @game.load.image('tree2', 'assets/tree2.png')

  loadRender:->
    @graphics.beginFill(0x00ff44)
    @graphics.drawRect(200, 340, 5 * @game.load.progress, 20)
    @graphics.endFill()

  render:->
    @loadRender()

  ready:=>
    @game.state.start('splash')

LaggyDash.Main = Main
