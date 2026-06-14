jQuery.fn.modal = (action) ->
  return this unless @length

  $modal = @first()

  switch action
    when 'show'
      $modal.addClass('show')
      $('body').addClass('modal-open')
      $modal.css(display: 'block', opacity: 0)
      $modal.find('.modal-dialog').css(transform: 'translateY(-30px)')

      # Плавное появление
      setTimeout ->
        $modal.css(opacity: 1)
        $modal.find('.modal-dialog').css(transform: 'translateY(0)')
      , 10

      $modal.trigger('shown.modal')

    when 'hide'
      # Плавное закрытие
      $modal.css(opacity: 0)
      $modal.find('.modal-dialog').css(transform: 'translateY(-30px)')

      setTimeout =>
        $modal.removeClass('show').css(display: 'none')
        $('body').removeClass('modal-open')
        $modal.trigger('hidden.modal')
      , 350  # совпадает с transition в CSS

  this


$ ->

  $(document).on 'click', '.modal.show', (e) ->
    if $(e.target).is('.modal')
      $(this).modal('hide')

  $(document).on 'click', '[data-dismiss="modal"]', (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(this).closest('.modal').modal('hide')

  $(document).on 'keydown.modal', (e) ->
    if e.key is 'Escape'
      $('.modal.show').modal('hide')