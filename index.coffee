# 
# Spotify Control widget for Übersicht
# Colin Ameigh
# github.com/medains/spotify-control
# 
# 

command: "osascript Spotify-Control.widget/script/query.as"

toggleScript: "osascript Spotify-Control.widget/script/command.as"
nextScript: "osascript Spotify-Control.widget/script/command.as next"
prevScript: "osascript Spotify-Control.widget/script/command.as prev"

# Lower the refresh frequency if you don't care so much about the progress indicator
refreshFrequency: '1s'

render: (output) -> """
  <style>
  @-webkit-keyframes left-one{
    0% {-webkit-transform: translateX(105%)}
    5% {-webkit-transform: translateX(0)}
    45% {-webkit-transform: translateX(0)}
    50% {-webkit-transform: translateX(-105%)}
    100% {-webkit-transform: translateX(-105%)}
  }

  @-webkit-keyframes left-two {
    0% {-webkit-transform: translateX(105%)}
    50% {-webkit-transform: translateX(105%)}
    55% {-webkit-transform: translateX(0)}
    95% {-webkit-transform: translateX(0)}
    100% {-webkit-transform: translateX(-105%)}
  }
  </style>
  <div id="prev">-</div>
  <div id="display">
  <span id="track"></span><span id="artist"></span><br/>
  <progress max="100" value="100" id="prog"/>
  </div>
  <div id="next">+</div>
"""

afterRender: (domEl) ->
    $(domEl).on 'click', '#track', => @run @toggleScript
    $(domEl).on 'click', '#artist', => @run @toggleScript
    $(domEl).on 'click', '#prog', => @run @toggleScript
    $(domEl).on 'click', '#next', => @run @nextScript
    $(domEl).on 'click', '#prev', => @run @prevScript

update: (output, domEl) ->
    data = JSON.parse(output)
    progress = data.progress
    duration = data.duration
    text = data.track + ' : ' + data.artist
    p = (100 * progress) / duration

    $(domEl).find("#track").text(data.track)
    $(domEl).find("#artist").text(data.artist)
    $(domEl).find("#prog").attr("value",p)

# the CSS style for this widget, written using Stylus
# (http://learnboost.github.io/stylus/)
style: """
  background: rgba(#fff, 0)
  box-sizing: border-box
  color: #ddd
  font-family: Helvetica Neue
  font-weight: 600
  font-smoothing: antialiased
  margin-left: 10px
  bottom: 1%
  left: 0%
  text-align: justify
  text-shadow: black 0px 0px 2px

  span
    line-height: 1.5
    height: 22px
    overflow: hidden

  div
    valign: center
    float: left
    overflow: hidden

  progress, progress[role]
    appearance: none
    -moz-appearance: none
    -webkit-appearance: none
    background-size: auto
    width: 400px
    height: 14px
    border: 2px solid rgba(220,220,220,0.6)
    border-radius: 9px
    box-sizing: border-box
    overflow: visible 

  progress[role]:after
    background-image: none

  progress[role] strong
    display: none;

  progress, progress[role][aria-valuenow]
    background: #777 !important

  progress::-webkit-progress-bar
    border-radius: 9px

  progress::-webkit-progress-value
    background: rgb(0,178,235)
    /*    box-shadow: 0px 0px 10px 1px rga(0,198,255,1)*/
    /* box shadow not showing - don't know why */
    border-radius: 9px

  #display
    width: 300px
    height: 48px
    overflow: hidden
    position: relative

  #display span
    position: absolute
    min-width: 300px
    margin: 0
    padding: 2px
    -webkit-transform: translateX(100%)

  #display span:nth-child(1)
    animation: left-one 20s ease infinite

  #display span:nth-child(2)
    animation: left-two 20s ease infinite

  #prog
    width: 100%

  #prev, #next
    padding: 10px
    font-size: 200%
"""
