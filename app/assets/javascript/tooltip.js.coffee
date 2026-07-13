tooltip = null

$(document).on 'mouseenter', '[data-tooltip]', ->
  el = $(this)

  tooltip?.remove()

  tooltip = $('<div class="tooltip-custom"></div>')
  tooltip.text(el.data('tooltip'))

  $('body').append(tooltip)

  rect = el[0].getBoundingClientRect()


  tooltip.css(
    left: rect.left + rect.width / 2
    top: rect.top - 5
    transform: 'translate(-50%, -100%)'
  )

  setTimeout ->

    return unless tooltip


    tooltipRect = tooltip[0].getBoundingClientRect()

    left = tooltipRect.left

    if tooltipRect.right > window.innerWidth
      left = window.innerWidth - tooltipRect.width - 10


    if left < 10
      left = 10

    tooltip.css(
      left: left
      transform: 'translateY(-100%)'
    )

    tooltip.addClass('show')
  , 0



$(document).on 'mouseleave', '[data-tooltip]', ->
  tooltip?.remove()
  tooltip = null