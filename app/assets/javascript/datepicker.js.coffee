jQuery.fn.datePicker = ->

  this.each ->

    flatpickr(this,
      locale: 'ru'
      dateFormat: 'Y-m-d'
    )

  this



jQuery.fn.datetimePicker = ->

  this.each ->

    flatpickr(this,
      locale: 'ru'
      enableTime: true
      dateFormat: 'Y-m-d H:i'
    )

  this



jQuery.fn.datetimePickerLimits = (options) ->

  this.each ->

    flatpickr(this,
      locale: 'ru'
      enableTime: true
      dateFormat: 'Y-m-d H:i'
      plugins: [
        new minMaxTimePlugin(
          table: options.table
        )
      ]
    )

  this