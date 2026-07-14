jQuery.fn.colorPicker = (last_color_title='last color') ->

  this.each ->
    input = this

    container = $('<div class="colorpicker"></div>')
    $(input).after(container)

    pickr = Pickr.create
      el: container[0]
      theme: 'classic'
      default: $(input).val() || '#000000'

      components:
        preview: true
        opacity: false
        hue: true

        interaction:
          hex: false
          input: true
          save: false

    pickr.on 'init', ->
      $(pickr.getRoot().app).find('.pcr-last-color').attr('data-tooltip', last_color_title)

      if $(input).val()
        $(pickr.getRoot().button).attr('style', "--pcr-color: #{$(input).val()};")

    pickr.on 'change', (color) ->
      hex = color.toHEXA().toString()

      $(input).val(hex)
      $(pickr.getRoot().button).attr('style', "--pcr-color: #{hex};")

  this