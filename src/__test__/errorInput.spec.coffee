G = null

describe 'GateWatcher', ->
  beforeEach -> 
    G = require '..'

  it 'when continuously judge the same attribute', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .option('attr', [String, Number])
        .parse()
    ).toBe true

  it 'when aption accepted array types of type', ->
    source = { attr: 2 }
    expect(
      G
        .input(source)
        .option('attr', [String, Number, Array])
        .parse()
    ).toBe true

  it 'when test a property continuously if has anyone case not pass just directly false', ->
    source = { attr: 2 }
    expect(
      G
        .input(source)
        .option('attr', String)
        .option('attr', Number)
        .option('attr', String)
        .parse()
    ).toBe false