$ ->
  
  $("#slider").slider
    value: 1
    min: 1
    max: 3
    slide: (event, ui) ->
      num = ui.value+1
      verbosity = while num -= 1 then 'v'
      $("#job_verbosity").val verbosity.join('')
	
  
  if $('#job-results').size() > 0
  
    div = $ '#job-results'
    project_id = div.data 'project_id'
    job_id = div.data 'job_id'
  
    get_job_status = ->
      $.getJSON "/projects/#{project_id}/jobs/#{job_id}", (data) ->
        if data.results == null
          setTimeout get_job_status, 3000
        else
          div.removeClass('hide').html data.results
          
          title = div.siblings('h3')
          title.find('img').remove()
          text = title.text().replace /Running/, 'Task'
          text = text.replace /\.\.\./, 'completed'
          title.text text
          
          $('.alert-message').remove()
          
          if data.success
            $('.tabs .pull-right').html '<span class="label success">SUCCESS</span>'
          else
            $('.tabs .pull-right').html '<span class="label important">FAILED</span>'
    
    setTimeout get_job_status, 3000
