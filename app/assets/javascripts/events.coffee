$(document).on 'ready page:load', ->
  $('#event-tags').tagit
    fieldName: 'event[tag_list]'
    singleField: true
