window.fix_text_area_height = ->
  textareas = document.querySelectorAll('textarea')

  for textarea in textareas
    do (textarea) ->

      set_height = ->
        textarea.style.height = 'auto'
        textarea.style.height = textarea.scrollHeight + 'px'

      setTimeout(set_height, 20)

      textarea.addEventListener 'input', set_height

$ ->

  document.querySelectorAll('.table-responsive').forEach (el) ->

    el.addEventListener 'wheel', (e) ->

      if el.scrollWidth > el.clientWidth

        e.preventDefault()
        e.stopPropagation()

        el.scrollLeft += e.deltaY

    , { passive: false }

  # $(document).on 'mouseover', '#sidebar .sidebar-body', ->
  #   sidebar_hidden = $('#sidebar').hasClass('hide')

  #   console.log("mouseover: #{sidebar_hidden}")
  #   $('#sidebar').removeClass('hide')
  #   $('.hide-sidebar-btn').show()
  #   $('.show-sidebar-btn').hide()

  # $(document).on 'mouseleave', '#sidebar .sidebar-body', ->
  #   sidebar_hidden = $('#sidebar').hasClass('hide')

  #   console.log("mouse_leave: #{sidebar_hidden}")
  #   if sidebar_hidden
  #     $('#sidebar').addClass('hide')
  #     $('.hide-sidebar-btn').hide()
  #     $('.show-sidebar-btn').show()

  $(document).on 'click', '.hide-show-sidebar', ->

    if window.innerWidth <= 767

      $('#sidebar').toggleClass('show')
      $('.overlay').toggleClass('show')
      $('body').toggleClass('sidebar-open')
      $('.sidebar-controls').hide()

      return

    $('#sidebar').toggleClass('hide')
    $('.hide-show-sidebar-btn').toggle()

    sidebar_hidden = $('#sidebar').hasClass('hide')

    $.ajax
      url: "/user_settings/set_sidebar_state"
      type: 'POST'
      dataType: 'script'
      data:
        sidebar_hidden: sidebar_hidden

  $(document).on 'click', '.overlay', ->

    $('#sidebar').removeClass('show')
    $('.overlay').removeClass('show')
    $('body').removeClass('sidebar-open')
    setTimeout ->
      $('.sidebar-controls').show()
    , 200

  $(document).on 'keydown', (e) ->

    return unless window.innerWidth <= 767

    return unless e.keyCode == 27

    $('#sidebar').removeClass('show')

    $('.overlay').removeClass('show')

  $(document).on 'click', '.tabs a', (e) ->
    e.preventDefault()

    target = $(this).attr('href')

    $('.tab-pane').removeClass('active')
    $(target).addClass('active')

    $('.tabs li').removeClass('active')
    $(this).parent().addClass('active')