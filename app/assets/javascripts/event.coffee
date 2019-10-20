$(document).on 'turbolinks:load', ->
  $('#event-tags').tagit
    fieldName: 'tag_list'
    singleField: true
  $('#event-tags').tagit()
  tag_string = $('#tag_hidden').val()
  try
    tag_list = tag_string.split(',')
    for tag in tag_list
      $('#event-tags').tagit 'createTag', tag
  catch error
