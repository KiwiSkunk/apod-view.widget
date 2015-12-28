#
# Based on Übersicht Widget to Earth View bacground
# By Nicholas Maggio
# Modified by Skunkworks Group 1-12-2015

# get image and resize to the screen dimensions
command: "perl -w 'apod-view.widget/apod.pl'";

# Set the refresh frequency (milliseconds).
refreshFrequency: 43200000

style: """
  top: 0%
  left: 0%
  color: #fff
    
  .apod
    height: 100%
    width: 100%
    position: absolute
    opacity: 1
    z-index:-1
       
"""

render: -> """
<div id='background'></div>
"""

# Update the rendered output.
update: (output, domEl) ->
  mydiv = $(domEl).find('div')
  html = ''
  
  html += "<div class='apod'>"
  html += "<img src='apod-view.widget/imgfit.jpg' >"
  html += "</div>"
  
  # Set the output
  mydiv.html(html)