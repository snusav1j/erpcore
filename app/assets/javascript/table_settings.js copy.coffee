draggedColumn = null
dragging = false
startX = 0
dropPosition = null

dragOffset = 0
originalLeft = 0


$(document).on 'mousedown', '.table-position-editor thead th:not(.nodraggable)', (e) ->

  th = $(this)

  return if th.hasClass('nodraggable')


  draggedColumn = th
  dragging = false

  startX = e.pageX

  dragOffset = e.pageX - th.offset().left
  originalLeft = th.offset().left


  th.addClass('dragging')



$(document).on 'mousemove', (e) ->

  return unless draggedColumn


  table = draggedColumn.closest('table')


  moveX = e.pageX - startX


  if Math.abs(moveX) > 10
    dragging = true


  return unless dragging


  # визуальное движение колонки
  currentX = e.pageX - dragOffset
  move = currentX - originalLeft

  draggedColumn.css(
    transform: "translateX(#{move}px)"
  )


  target = null
  dropPosition = null


  table.find('thead th:not(.nodraggable)').each ->

    item = $(this)

    return if item.is(draggedColumn)


    offset = item.offset()
    width = item.outerWidth()


    if e.pageX > offset.left and e.pageX < offset.left + width

      target = item


      if e.pageX < offset.left + width / 2
        dropPosition = 'before'
      else
        dropPosition = 'after'



  # если тянем в конец таблицы
  if !target

    last = table.find('thead th:not(.nodraggable)').last()

    if last.length

      offset = last.offset()

      if e.pageX > offset.left + last.outerWidth()

        target = last
        dropPosition = 'after'



  # если тянем в начало таблицы
  if !target

    first = table.find('thead th:not(.nodraggable)').first()

    if first.length

      offset = first.offset()

      if e.pageX < offset.left

        target = first
        dropPosition = 'before'



  table.find('th').removeClass('column-target-before column-target-after')


  if target

    if dropPosition == 'before'
      target.addClass('column-target-before')
    else
      target.addClass('column-target-after')



$(document).on 'mouseup', (e) ->

  return unless draggedColumn


  th = draggedColumn
  table = th.closest('table')


  target = table.find('th.column-target-before, th.column-target-after')


  if dragging and target.length and dropPosition

    from = th.index()
    targetIndex = target.index()


    if dropPosition == 'before'


      table.find('thead th').eq(targetIndex).before(th)


      table.find('tbody tr').each ->

        row = $(this)

        cell = row.find('td').eq(from)

        row.find('td').eq(targetIndex).before(cell)



    else


      table.find('thead th').eq(targetIndex).after(th)


      table.find('tbody tr').each ->

        row = $(this)

        cell = row.find('td').eq(from)

        row.find('td').eq(targetIndex).after(cell)



    saveColumnPosition(table)



  resetDrag()



resetDrag = ->

  if draggedColumn

    draggedColumn.css(
      transform: ''
    )


  $('.table-position-editor th').removeClass('dragging column-target-before column-target-after')


  draggedColumn = null
  dragging = false
  dropPosition = null
  dragOffset = 0
  originalLeft = 0



saveColumnPosition = (table) ->

  columns = []


  table.find('thead th:not(.nodraggable)').each ->

    key = $(this).data('column-key')

    columns.push(key.toString()) if key



  $.ajax

    url: '/table_settings/update_positions'

    method: 'PATCH'

    data:
      entity: table.data('entity')
      columns: columns