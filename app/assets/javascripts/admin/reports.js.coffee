#= require jasny-bootstrap.min
#= require moment
#= require bootstrap-daterangepicker

window['admin/reports#index'] = (data) ->
  $('#report_date_range').daterangepicker({
    opens: 'left'
  })
