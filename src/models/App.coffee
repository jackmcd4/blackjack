# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'game', game = new Game()

    @listenTo @get('playerHand'), 'hit', @checkPlayerHand
    # @listenTo @get('playerHand'), 'hit', @checkHand
    @listenTo @get('playerHand'), 'stand', @playDealerHand


  checkPlayerHand: ->
    scoresArr = @get('playerHand').scores()
    console.log scoresArr
    if scoresArr[0] > 21
      debugger

  playDealerHand: ->
    @flipDealerCard()
    @dealerCheck()

  getPlayer: ->
    @get 'playerHand'

  flipDealerCard: ->
    dealerHand = @get('dealerHand')
    dealerHand.models[0].flip()

  dealerCheck: ->
    while (@get('dealerHand').scores())[1] < 17
      debugger
      @dealerHit()

  dealerHit: ->
    @get('dealerHand').hit()

  dealerCompare: ->
    value = undefined
    if @get('playerHand').scores()[1] > 21
      @get('dealerHand').scores()[1] > @get('playerHand').scores()[0]
    else
      value = @get('playerHand').scores()[1]

  dealerLose: ->

  dealerWin: ->

  tie: ->

  dealerCheck: ->
    dealerScore = @get('dealerHand').scores()
    playerScore = @get('playerHand').scores()
    pScore = playerScore[1]
    if pScore > 21 then pScore = playerScore[0]

    if dealerScore[1] > 21 && dealerScore[0] > 21
      @dealerLose()
    else if dealerScore[1] > pScore && dealerScore[1] < 21
      @dealerWin()
    else if dealerScore[0] > pScore && dealerScore[0] < 21
      @dealerWin()
    else if pScore == 21 && dealerScore[1] == 21 || pScore == 21 && dealerScore[0] == 21
      @tie()
    else
      @dealerHit()

###
