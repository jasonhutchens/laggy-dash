LaggyDash = window.LaggyDash

class Landscape extends Phaser.State
  SPEED = 1

  constructor:->

  preload:->
    window.laggydash.connect('laggydash', laggydash.game.rnd.uuid() + ":#{@game.player_name}")

  create:->
    @game.stage.backgroundColor = '#000055'

    @night = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'night')
    @night.alpha = 0
    @night.anchor.setTo(0.5, 0.5)

    fade = @game.add.tween(@night)
    fade.to({ alpha: 1 }, 300000 / SPEED, Phaser.Easing.Linear.None, true, 150000 / SPEED, 999, true)
    fade.start

    @sky = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'sky')
    @sky.alpha = 1
    @sky.anchor.setTo(0.5, 0.5)

    fade = @game.add.tween(@sky)
    fade.to({ alpha: 0 }, 450000 / SPEED, Phaser.Easing.Linear.None, true, 0, 999, true)
    fade.start

    @sun = @game.add.sprite(0, 0, 'sun')
    @sun.anchor.setTo(0.5, 0.5)
    @sun.scale.setTo(0.3, 0.4)
    @sun.x = @game.world.centerX
    @sun.y = @game.world.centerY * 0.5 - 100

    grow = @game.add.tween(@sun.scale)
    grow.to({ x: 1.5, y: 1.5 }, 450000 / SPEED, Phaser.Easing.Cubic.InOut, true, 0, 999, true)
    grow.start

    set = @game.add.tween(@sun)
    set.to({ y: 675 }, 450000 / SPEED, Phaser.Easing.Sinusoidal.InOut, true, 0, 999, true)
    set.start

    fade = @game.add.tween(@sun)
    fade.to({ alpha: 0 }, 450000 / SPEED, Phaser.Easing.Linear.None, true, 0, true, true)
    fade.start

    @cloud = @game.add.sprite(1000, 70, 'cloud')
    @cloud.alpha = 0.4
    move = @game.add.tween(@cloud)
    move.to({x: -800}, 70000 / SPEED, Phaser.Easing.Linear.None, true, 0, 999)
    move.start

    @mountain0a = @game.add.sprite(0, 180, 'mountain0')
    @mountain0b = @game.add.sprite(2000, 180, 'mountain0')

    @player_group = @game.add.group()

    @coin = @game.add.sprite(400, 250, 'coin')
    @coin.anchor.setTo(0.5, 0.5)
    @bomb = @game.add.sprite(450, 250, 'bomb')
    @bomb.anchor.setTo(0.5, 0.5)
    @explosion = @game.add.sprite(500, 250, 'explosion')
    @explosion.anchor.setTo(0.5, 0.5)

    @mountain1a = @game.add.sprite(0, 180, 'mountain1')
    @mountain1b = @game.add.sprite(2000, 180, 'mountain1')

    @mountain1a.alpha = 0.95
    @mountain1b.alpha = 0.95

    @mountain2a = @game.add.sprite(0, 180, 'mountain2')
    @mountain2b = @game.add.sprite(2000, 180, 'mountain2')

    @mountain3a = @game.add.sprite(0, 180, 'mountain3')
    @mountain3b = @game.add.sprite(2000, 180, 'mountain3')
    @mountain3a.alpha = 0.4
    @mountain3b.alpha = 0.4

    @avatar_group = @game.add.group()

    @tree0 = @game.add.sprite(2000, 490, 'tree0')
    @tree0.anchor.setTo(0.5, 1)
    move = @game.add.tween(@tree0)
    move.to({x: -2000}, 3400 / SPEED, Phaser.Easing.Linear.None, true, 3000 / SPEED, 999)
    move.start

    @tree1 = @game.add.sprite(2000, 490, 'tree1')
    @tree1.anchor.setTo(0.5, 1)
    move = @game.add.tween(@tree1)
    move.to({x: -2000}, 3500 / SPEED, Phaser.Easing.Linear.None, true, 7000 / SPEED, 999)
    move.start

    @tree2 = @game.add.sprite(2000, 490, 'tree2')
    @tree2.anchor.setTo(0.5, 1)
    move = @game.add.tween(@tree2)
    move.to({x: -2000}, 3600 / SPEED, Phaser.Easing.Linear.None, true, 13000 / SPEED, 999)
    move.start

    @tree3 = @game.add.sprite(2000, 490, 'tree3')
    @tree3.anchor.setTo(0.5, 1)
    move = @game.add.tween(@tree3)
    move.to({x: -2000}, 3400 / SPEED, Phaser.Easing.Linear.None, true, 17000 / SPEED, 999)
    move.start

    @grass1 = @game.add.sprite(0, 380, 'grass')
    @grass2 = @game.add.sprite(896, 380, 'grass')

    @label_group = @game.add.group()

    @position = 0
    @players = {}
    @addPlayer(laggydash.user.replace(/:.*$/, ''), @game.player_name, true)

  update:->
    @position += 1

    @grass1.x -= 20 * SPEED
    @grass2.x -= 20 * SPEED
    @grass1.x += 896 * 2 if @grass1.x <= -896
    @grass2.x += 896 * 2 if @grass2.x <= -896

    @mountain0a.x -= 1.1 * SPEED
    @mountain0b.x -= 1.1 * SPEED
    @mountain0a.x += 2000 * 2 if @mountain0a.x <= -2000
    @mountain0b.x += 2000 * 2 if @mountain0b.x <= -2000

    @mountain1a.x -= 1.7 * SPEED
    @mountain1b.x -= 1.7 * SPEED
    @mountain1a.x += 2000 * 2 if @mountain1a.x <= -2000
    @mountain1b.x += 2000 * 2 if @mountain1b.x <= -2000

    @mountain2a.x -= 2.3 * SPEED
    @mountain2b.x -= 2.3 * SPEED
    @mountain2a.x += 2000 * 2 if @mountain2a.x <= -2000
    @mountain2b.x += 2000 * 2 if @mountain2b.x <= -2000

    @mountain3a.x -= 2.9 * SPEED
    @mountain3b.x -= 2.9 * SPEED
    @mountain3a.x += 2000 * 2 if @mountain3a.x <= -2000
    @mountain3b.x += 2000 * 2 if @mountain3b.x <= -2000

    @player_group.forEach (player)=>
      if @position % 7 == 0
        player.frame = (player.frame + 1) % 6

    if @position % 7 == 0
      @coin.frame = (@coin.frame + 1) % 6
      @bomb.frame = (@bomb.frame + 1) % 6
      @explosion.frame = (@explosion.frame + 1) % 4

  addPlayer:(id, name, isPlayer=false)->
    x = if isPlayer then 600 else 300
    s = if isPlayer then 'runner' else 'wolf'

    runner = @game.add.sprite(x, 300, s)
    runner.scale.setTo(0.5, 0.5) if isPlayer
    runner.anchor.setTo(0.5, 1.0)

    @player_group.add(runner)

    avatar = @game.add.sprite(x, 475, "@#{name}")
    avatar.id = id
    avatar.name = name
    avatar.width = 60
    avatar.height = 60
    avatar.anchor.setTo(0.5, 1.0)
    avatar.alpha = 0.8
    avatar.inputEnabled = true
    avatar.useHandCursor = true
    avatar.events.onInputDown.add =>
      window.laggydash.showUser(name)

#   pen = @game.add.graphics(0, 0)
#   pen.lineStyle(2, 0xffd900, 0.5)
#   pen.moveTo(runner.x, runner.y)
#   pen.lineTo(avatar.x, avatar.y - 65)

    @avatar_group.add(avatar)

    style =
      font: "10pt Courier"
      fill: "#ffffff"

    label = @game.add.text(x, 480, "@#{name}", style)
    label.x -= label.width / 2

    @label_group.add(label)

    @players[id] =
      runner: runner
      avatar: avatar
      label: label

  delPlayer:(id)->
    return unless @players[id]?
    @players[id].runner.destroy()
    @players[id].avatar.destroy()
    @players[id].label.destroy()
    delete(@players[id])

  avatarLoaded:(key)->
    @avatar_group.forEach (avatar)=>
      if avatar.key == "__missing" && key == "@#{avatar.name}"
        avatar.loadTexture(key)
        avatar.width = 60
        avatar.height = 60

  handle:(remote)->
    switch remote.action
      when 'join'
        @addPlayer(remote.id, remote.name)
      when 'bail'
        @delPlayer(remote.id)

  delMob:(id, name)->
    console.log("ADD #{name}")

  destroy:->
    destroy(@tree0)
    destroy(@tree1)
    destroy(@tree2)
    destroy(@tree3)
    destroy(@night)
    destroy(@sky)
    destroy(@sun)
    destroy(@cloud)
    destroy(@grass1)
    destroy(@grass2)
    destroy(@runner)

  done:=>
    @game.state.start('splash')

LaggyDash.Landscape = Landscape
