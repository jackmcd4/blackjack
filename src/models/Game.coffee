class window.Game extends Backbone.Model
  initialize: ->

# card.score changed, therefore we need to check the rules and return whatever happens next
###
  dealerCheck: ->
    while (@get('dealerHand').scores())[1] < 17
      debugger
      @dealerHit()
###
