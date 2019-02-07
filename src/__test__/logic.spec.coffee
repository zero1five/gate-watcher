G = null

describe 'GateWatcher', ->
  beforeEach -> 
    G = require '..'

  it 'when input get value not of object"s type', ->
    expect(
      -> G.input([]).parse()
    ).toThrowError 'GateWatcher only accept object as input'

  it 'when again input value', ->
    source = {}
    _source = {}
    expect(
      -> G.input(source).input(_source).parse()
    ).toThrowError "don't repeat input value, GateWatcher only accept once value"

  it 'when there are a lot of options with different parameters', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .option('attr', Number)
        .option('side', String, 'side')
        .option('attr', Number, 10)
        .parse()
    ).toBe true

  it 'when value and type of option not match', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .option('attr', String)
        .parse()
    ).toBe false

  it 'when accept empty of option', ->
    source = { attr: 1 }
    expect( -> 
      G
        .input(source)
        .option()
        .parse()
    ).toThrowError 'option requires at least one param'

  it 'equivalent input and output', ->
    source = { attr: 1 }
    G
      .input(source)
      .option('attr', String, 'attr')
      .parse()

    expect(
      source.attr
    ).toBe 1

  it 'when the action matches', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .option('attr', Number)
        .action(
          (target) -> target.attr == 1
          (target) -> target.side = 10
        )
        .parse()
    ).toBe true

  it 'when the action not matches and no options match', ->
    source = { attr: 1 }
    expect(
      G
        .input(source)
        .option('attr', Number)
        .option('side', String)
        .action(
          (target) -> target.attr == 10
          (targe) -> target.attr = 1
        )
        .parse()
    ).toBe false

  it 'when no options case', -> 
    source = {}
    expect(
      G
        .input(source)
        .action(
          (target) -> target.attr == 10
          (targe) -> target.attr = 1
        )
        .parse()
    ).toBe false

  it 'when using all features', ->
    source = { attr: 12345 }
    expect(
      G
        .input(source)
        .option('attr')
        .option('side', String, 'side')
        .option('list', Array, [1,2,3])
        .action(
          (target) -> target.attr == 1
          (target) -> target.effect = 99
        )
        .parse()
    ).toBe true

  it 'when the test attribute is zero', ->
    source = { attr: 0 }
    expect(
      G
        .input(source)
        .option('attr', Number)
        .parse()
    ).toBe true

  it 'when exist attributes', -> 
    source = { attr: 0 }
    expect(
      G
        .input(source)
        .exist(['attr', 'side', 'outer'])
        .parse()
    ).toBe true

  it 'when accepted wrong input in the exist api', ->
    expect(
      -> G.input({}).exist('attr').parse()
    ).toThrowError 'exist requires at least one param and type of attributes must is array.'

  it 'when exist not matches', ->
    source = { attr: 0 }
    expect(
      G
        .input(source)
        .exist(['side', 'inner', 'outer'])
        .parse()
    ).toBe false

  it 'when exist can matches', ->
    source = { attr: 0 }
    expect(
      G
        .input(source)
        .exist(['side', 'inner', 'attr'])
        .parse()
    ).toBe true