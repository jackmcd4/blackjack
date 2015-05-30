# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @gameProperties()
    # @set 'game', game = new Game()
    #@listenTo @get('playerHand'), 'hit', @checkPlayerHand, @
    # @listenTo @get('playerHand'), 'hit', @checkHand
    #@listenTo @get('playerHand'), 'stand', @playDealerHand, @
    #@listenTo @get('dealerHand'), 'hit', @dealerCheck, @

  checkPlayerHand: ->
    debugger
    scoresArr = @get('playerHand').scores()
    console.log scoresArr
    if scoresArr[0] > 21
      @dealerWin();

  playDealerHand: ->
    debugger
    @flipDealerCard()
    @dealerCheck()

  gameProperties: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameStatus', ''
    @listenTo @get('playerHand'), 'hit', @checkPlayerHand, @
    @listenTo @get('playerHand'), 'stand', @playDealerHand, @
    @listenTo @get('dealerHand'), 'hit', @dealerCheck, @


  getPlayer: ->
    @get 'playerHand'

  flipDealerCard: ->
    dealerHand = @get('dealerHand')
    dealerHand.models[0].flip()

  dealerHit: ->
    @get('dealerHand').hit()

  dealerCompare: ->
    value = undefined
    if @get('playerHand').scores()[1] > 21
      @get('dealerHand').scores()[1] > @get('playerHand').scores()[0]
    else
      value = @get('playerHand').scores()[1]

  dealerLose: ->
    @set('gameStatus', 'Let me get my money back...')

  dealerWin: ->
    @set('gameStatus', 'Bitch, you lost')

  tie: ->
    @set('gameStatus', 'Dealer mad, it\'s a tie')

  dealerCheck: ->
    dealerScore = @get('dealerHand').scores()
    playerScore = @get('playerHand').scores()
    pScore = playerScore[1]
    if pScore > 21 then pScore = playerScore[0]
    if dealerScore[1] < 17 then setTimeout @dealerHit.bind(@), 1500
    else if dealerScore[1] > 21 && dealerScore[0] < 17 then setTimeout @dealerHit.bind(@), 1500
    else if dealerScore[1] > 21 && dealerScore[0] > 21
      setTimeout @dealerLose.bind(@), 1000
    else if dealerScore[1] > pScore && dealerScore[1] <= 21
      setTimeout @dealerWin.bind(@), 1000
    else if dealerScore[0] > pScore && dealerScore[0] <= 21
      setTimeout @dealerWin.bind(@), 1000
    else if (pScore == 21 && dealerScore[1] == 21) || (pScore == 21 && dealerScore[0] == 21)
      setTimeout @tie.bind(@), 1000
    else
      setTimeout @dealerHit.bind(@), 1500

