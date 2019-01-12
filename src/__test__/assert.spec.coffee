G = null

describe 'GateWatcher', ->
  beforeEach -> 
    G = require '..'

  it 'when accepted wrong input', ->
    expect(
      -> G.input('').input(1).input(Boolean).parse()
    ).toThrowError 'GateWatcher only accept object as input'

  it 'when accepted empty object', ->
    expect(
      G.input({}).parse()
    ).toBe false

  it 'when accepted integral logic', ->
    source = { a: 1, b: 'b' }
    expect(
      G
        .input(source)
        .option('a', Number)
        .option('b', String)
        .option('c', Boolean, true)
        .option('d', Array, [])
        .option('e', Object, { f: 1 })
        .parse()
    ).toBe true