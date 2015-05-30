class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  templateEnd: _.template '
    <button class="play-again">Play Again</button>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .play-again': -> @newGame()

  initialize: ->
    @listenTo(@model,'change:gameStatus', @renderGameStatus)
    @render()

  newGame: ->
    #debugger
    @model.gameProperties()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    debugger
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderGameStatus: ->
    callback = @model.get('gameStatus')
    if callback != ''
      @$el.append "<h1>#{callback}</h1>"
      @$el.append @templateEnd()
    # @$el.detach()
    # debugger
