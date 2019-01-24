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

  it 'when action not match by options match this attr', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .action(
          (target) -> target.attr == 10,
          (target) -> target.side = 199
        )
        .option('side', Number, 199)
        .parse()
    ).toBe true

  it 'when options received three paramters', ->
    source = { attr: 1 }
    G
      .input(source)
      .option('side', [String, Number], 199)
      .parse()
    expect(
      source.side
    ).toBe 199
  
  it 'when action received error input', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .action(
          (target) -> target,
          (target) -> target = target
        )
        .option("attr", Number)
        .parse()
    ).toBe true

  it 'when there are multiple attributes', ->
    source = { c: 1 }
    expect(
      G
        .input(source)
        .option(['a', 'b', 'c'])
        .parse()
    ).toBe true

  it 'when there are multiple attributes and has received type', ->
    source = { c: 1 }
    expect(
      G
        .input(source)
        .option(['a', 'b', 'c'], Number)
        .parse()
    ).toBe true