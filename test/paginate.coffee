chai = require 'chai'
mongoose = require 'mongoose'

should = chai.should()

require '../lib/pagination'

describe 'Mongoose Pagination', ->
  query = null

  beforeEach ->
    query = new mongoose.Query

  it 'should add a paginate method to Query\s prototype', ->
    should.exist(mongoose.Query.prototype.paginate)

  describe 'defaults', ->
    beforeEach ->
      query.paginate()

    it 'should skip to 0', ->
      query.options.should.include.keys 'skip'
      query.options.skip.should.be.eq 0
    it 'should limit to 10', ->
      query.options.should.include.keys 'limit'
      query.options.limit.should.be.eq 10

  describe 'paginate', ->
    it 'should skip 10 when page is 2', ->
      query.paginate 2
      query.options.should.include.keys 'skip'
      query.options.skip.should.be.eq 10

    it 'should skip 20 when page is 3', ->
      query.paginate 3
      query.options.should.include.keys 'skip'
      query.options.skip.should.be.eq 20

    it 'should skip 30 when page is 3 and limit is 15', ->
      query.paginate 3, 15
      query.options.should.include.keys 'skip', 'limit'
      query.options.skip.should.be.eq 30
      query.options.limit.should.be.eq 15
