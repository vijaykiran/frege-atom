FregeView = require './frege-view'
{CompositeDisposable} = require 'atom'

module.exports = Frege =
  fregeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @fregeView = new FregeView(state.fregeViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @fregeView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'frege:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @fregeView.destroy()

  serialize: ->
    fregeViewState: @fregeView.serialize()

  toggle: ->
    console.log 'Frege was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
