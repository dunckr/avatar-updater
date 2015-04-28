window.$ = $ = require "../vendor/jquery/dist/jquery"
glitch = require "../vendor/glitch-canvas/dist/glitch-canvas"

$ ->
  $canvas = $("canvas")
  canvas = $canvas[0]
  ctx = canvas.getContext("2d")
  img = new Image()
  img.onload= ->
    canvas.width = 1600
    canvas.height = 1600
    ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, 1600, 1600)
    imgData = ctx.getImageData(0, 0, canvas.clientWidth, canvas.clientHeight)
    params =
      amount: random(1, 20)
      seed: random(1, 20)
      iterations: random(1, 20)
      quality: 100
    drawGlitchedImageData = (imgData) ->
      ctx.putImageData(imgData, 0, 0)
      b64 = canvas.toDataURL()
      upload(b64)
    glitch(imgData, params, drawGlitchedImageData)

  img.src="images/profile.jpg"

upload = (data) ->
  params =
    b64: data
  $.ajax(
    type: "POST",
    url: "/avatar",
    contentType: "application/json"
    dataType: "json"
    data: JSON.stringify(params)
  ).done (data) ->
    console.log "saved #{data}"
    bg()

bg = ->
  $.get "/bg", (data) ->
    console.log data

random = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min
