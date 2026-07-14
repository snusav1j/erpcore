draggedKey = null
dragClone = null
columnIndicator = null

dragging = false

startX = 0
mouseOffsetX = 0
cloneStartLeft = 0

dropTargetKey = null
dropPosition = null

originalOrder = []



$(document).on 'mousedown', '.table-position-editor.active thead th:not(.static-position)', (e) ->

  e.preventDefault()

  th = $(this)

  return if th.hasClass('static-position')

  table = th.closest('table')

  originalOrder = []

  table.find('thead th:not(.static-position)').each ->

    key = $(this).data('column-key')

    originalOrder.push(key.toString()) if key



  draggedKey = th.data('column-key')
  td = table.find("[data-column-key='#{draggedKey}']")

  startX = e.pageX

  mouseOffsetX = e.pageX - th.offset().left

  cloneStartLeft = th.offset().left


  createDragClone(table, draggedKey)

  createIndicator()

  th.addClass('dragging')
  td.addClass('dragging')


$(document).on 'mousemove', (e) ->

  return unless draggedKey


  if Math.abs(e.pageX - startX) > 5
    dragging = true


  return unless dragging


  table = $('.table-position-editor.active').first()


  if dragClone

    dragClone.css(
      transform: "translateX(#{e.pageX - mouseOffsetX - cloneStartLeft}px)"
      top: table.offset().top
    )



  calculateDrop(
    e.pageX,
    table
  )



$(document).on 'mouseup', ->

  return unless draggedKey


  if dragging and dropTargetKey

    table = $('.table-position-editor.active').first()


    moveColumn(
      table,
      draggedKey,
      dropTargetKey,
      dropPosition
    )


    if columnsChanged(table)

      saveColumnPosition(table)



  destroyDrag()



createDragClone = (table, key) ->

  clone = $('<div class="column-drag-clone"></div>')


  table.find('tr').each ->

    cell = $(this)
      .find("[data-column-key='#{key}']")
      .clone()


    cell.removeAttr('id')

    cell.addClass('drag-cell')


    clone.append(cell)



  $('body').append(clone)


  source = table.find(
    "[data-column-key='#{key}']"
  ).first()


  clone.css(
    left: source.offset().left
    top: table.offset().top
    width: source.outerWidth()
  )


  dragClone = clone



createIndicator = ->

  columnIndicator = $('<div class="column-indicator"></div>')

  $('body').append(columnIndicator)



calculateDrop = (mouseX, table) ->


  dropTargetKey = null
  dropPosition = null


  closestDistance = Infinity


  table.find(
    'thead th:not(.static-position)'
  ).each ->


    th = $(this)

    key = th.data('column-key')


    return if key == draggedKey


    left = th.offset().left

    right = left + th.outerWidth()


    leftDistance = Math.abs(mouseX - left)

    rightDistance = Math.abs(mouseX - right)



    if leftDistance < closestDistance

      closestDistance = leftDistance

      dropTargetKey = key

      dropPosition = 'before'

      moveIndicator(left, th)



    if rightDistance < closestDistance

      closestDistance = rightDistance

      dropTargetKey = key

      dropPosition = 'after'

      moveIndicator(right, th)



moveIndicator = (x, th) ->

  columnIndicator.css(
    left: x - 1
    top: th.closest('table').offset().top
    height: th.closest('table').height()
  )



moveColumn = (table, key, targetKey, position) ->


  sourceTh = table.find(
    "thead th[data-column-key='#{key}']"
  )


  targetTh = table.find(
    "thead th[data-column-key='#{targetKey}']"
  )



  if position == 'before'

    targetTh.before(sourceTh)

  else

    targetTh.after(sourceTh)



  table.find('tbody tr').each ->

    row = $(this)


    sourceTd = row.find(
      "td[data-column-key='#{key}']"
    )


    targetTd = row.find(
      "td[data-column-key='#{targetKey}']"
    )



    if position == 'before'

      targetTd.before(sourceTd)

    else

      targetTd.after(sourceTd)



columnsChanged = (table) ->

  currentOrder = []


  table.find(
    'thead th:not(.static-position)'
  ).each ->

    key = $(this).data('column-key')

    currentOrder.push(
      key.toString()
    ) if key



  JSON.stringify(originalOrder) != JSON.stringify(currentOrder)



saveColumnPosition = (table) ->


  columns = []


  table.find(
    'thead th:not(.static-position)'
  ).each ->

    key = $(this).data('column-key')

    columns.push(
      key.toString()
    ) if key



  $.ajax

    url: '/table_settings/update_positions'

    method: 'PATCH'

    data:

      entity: table.data('entity')

      columns: columns



destroyDrag = ->

  $('.column-drag-clone').remove()

  $('.column-indicator').remove()

  $('.table-position-editor.active th').removeClass('dragging')
  $('.table-position-editor.active td').removeClass('dragging')

  draggedKey = null

  dragClone = null

  columnIndicator = null


  dragging = false

  dropTargetKey = null

  dropPosition = null

  originalOrder = []

$(document).on 'change', '#edit_column_position', (e) ->
  checked = $(this).prop('checked')
  if checked
    $('.table-position-editor').addClass('active')
  else
    $('.table-position-editor').removeClass('active')