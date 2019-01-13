G = null

describe 'GateWatcher', ->
  beforeEach -> 
    G = require '..'

  it 'when continuously judge the same attribute', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .option('attr', String)
        .option('attr', Number)
        .parse()
    ).toBe true

  