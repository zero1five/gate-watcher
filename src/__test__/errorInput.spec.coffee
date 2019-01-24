G = null

describe 'GateWatcher', ->
  beforeEach -> 
    G = require '..'

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