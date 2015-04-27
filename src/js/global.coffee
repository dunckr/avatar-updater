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
      amount: 5
      seed: 5
      iterations: 9
      quality: 100
    drawGlitchedImageData = (imgData) ->
      ctx.putImageData(imgData, 0, 0)
    glitch(imgData, params, drawGlitchedImageData)

  img.src="images/profile.jpg"

  $canvas.click ->
    b64 = canvas.toDataURL()
    params =
      b64: b64
    $.ajax(
      type: "POST",
      url: "/avatar",
      contentType: "application/json"
      dataType: "json"
      data: JSON.stringify(params)
    ).done (o) ->
      console.log("saved")
